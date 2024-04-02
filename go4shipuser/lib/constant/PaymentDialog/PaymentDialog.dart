import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../DialogUtils.dart';



class PaymentDialog {
  static PaymentDialog _instance = new PaymentDialog.internal();

  PaymentDialog.internal();

  factory PaymentDialog() => _instance;
  static void showCustomDialog(BuildContext context, {required String message, String okBtnText = "Ok",}) {

    final TextEditingController _amountController = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(

            actions: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.cyan,
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: SizedBox(
                                width: 50,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                      child: Center(
                                        child: Text(
                                          'Add Money',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.white, fontSize: 13),
                                        ),
                                      )),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 100,
                      child: Column(
                        children: [

                          SizedBox(height: 20,),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                                hintText: 'Amount in INR'),
                          ),
                        ],
                      ),

                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        if(_amountController.text.isEmpty){
                          DialogUtils.showCustomDialog(context, message: 'Please Enter your Amount');
                        }else if(int.parse(_amountController.text)< 100){
                          DialogUtils.showCustomDialog(context, message: 'Please Recharge your wallet at least 100 Rs');
                        }else{

                          Razorpay razorpay = Razorpay();
                          var options = {
                            'key': 'rzp_test_1DP5mmOlF5G5ag',
                            'amount': int.parse(_amountController.text)*100,
                            'name': 'Go4Ship',
                            'description': 'Recharge',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '8888888888',
                              'email': 'test@razorpay.com'
                            },
                            'external': {
                              'wallets': ['paytm']
                            }

                          };
                          razorpay.on(
                              Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          razorpay.open(options);
                        }

                      },
                      child:   Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.cyan,
                        ),
                        child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white,fontSize: 18),
                            'Submit')),
                      ) ,
                    ),
                  ],

                ),
              )

            ],
          );
        });


  }


  static void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    Fluttertoast.showToast(
        msg: 'Payment Failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white);
    /*  showAlertDialog(context, "Payment Failed",
          "Code: ${response.code}\nDescription: ${response.message}\nMetadata:}");*/
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    Fluttertoast.showToast(
        msg: 'Payment Successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white);
    // showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  static void handleExternalWalletSelected(ExternalWalletResponse response) {
    /* showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");*/

    Fluttertoast.showToast(
        msg: 'External Wallet Selected',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

}