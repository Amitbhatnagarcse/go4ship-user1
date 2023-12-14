import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/AppColor.dart';
import 'constant/AppUrl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late SharedPreferences preferences;
  String refer_count='';
  String refer_amount = '';
  String wallet_balance = '';
  @override
  void initState() {
    getWalletData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Wallet'), backgroundColor: ColorConstants.AppColorDark),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      'Referral Credits'),
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                            color: Colors.blue.shade100,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: Text('Total Referral'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: Text(style: TextStyle(fontSize: 25),refer_count.toString()),
                                ),
                              ],
                            ),
                          )),

                      Expanded(
                          child: Card(
                            color: Colors.pinkAccent.shade100,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: Text('Credits Earned'),
                                ),

                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: Text(style: TextStyle(fontSize: 25),refer_amount.toString()),
                                ),
                              ],
                            ),
                          )),

                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: Card(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black),'Balance'),
                    Center(child: Text(style: TextStyle(fontSize: 25),wallet_balance))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Container(
                    height: 50,
                    color: Colors.deepOrange,
                    child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),'Add Money')),
                  )),

                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Container(
                    height: 50,
                    color: CupertinoColors.activeBlue,
                    child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),'Money Transfer')),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(

              child: Card(
                child: Column(

                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: Colors.white,
                          child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),'Your Referrals')),
                        )),

                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: CupertinoColors.white,
                          child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),'Your Transactions')),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: const Icon(Icons.list),
                                trailing: const Text(
                                  "GFG",
                                  style: TextStyle(color: Colors.green, fontSize: 15),
                                ),
                                title: Text("List item $index"));
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getWalletData() async {


    preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({

        AppConstants.UserId: preferences.getString('userid'),
        AppConstants.ReferralCode: preferences.getString('uid'),

      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.UserWallet_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          //cablist = response.data['result'][0]['cabtypes'] as List;

          var resut= response.data['result'];
          print('print response/////   ${response.data['result'][0]['referral']}');
          print('print response////  ${response.data['result'][1]['info']}');
          print('print response////  ${response.data['result'][2]['transaction']}');
          if(resut != null){
            print('print response////  ${response.data['result'][1]['info'][0]['refer_count'].toString()}');
            refer_count = response.data['result'][1]['info'][0]['refer_count'].toString();
            refer_amount = response.data['result'][1]['info'][0]['refer_amount'].toString();
            wallet_balance = response.data['result'][1]['info'][0]['wallet_balance'].toString();
            //_phonecontroller.text = response.data['result'][0]['phone'];

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          }else{
            print('Please Enter Valid Details');
          }
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
