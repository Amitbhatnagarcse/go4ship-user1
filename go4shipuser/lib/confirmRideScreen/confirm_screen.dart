import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go4shipuser/confirmRideScreen/PackageModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';
import '../constant/DialogUtils.dart';
import '../walletscreen.dart';

class ConfirmScreen extends StatefulWidget {
  final String cabid;
  final String headertext;
  final String VhecletypeName;
  final String droplocation;
  final String droplat;
  final String droplong;
  final String ride_id;

  final List locationAddlist;
  final List pickuplat_list;

  final List pickuplong_list;

  const ConfirmScreen({
    Key? key,
    required this.cabid,
    required this.headertext,
    required this.VhecletypeName,
    required this.droplocation,
    required this.droplat,
    required this.droplong,
    required this.ride_id,
    required this.locationAddlist,
    required this.pickuplat_list,
    required this.pickuplong_list,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late String pickuplocation;
  late String pickuplat;
  late String pickuplang;
  late String packageid;
  late SharedPreferences preferences;

  //String pay_type = '3';
  String? pay_type_;
  PayTypeData? pay_type = PayTypeData.Wallet;
  TextEditingController _changePackagetext = TextEditingController();
  var _changepackText = 'Select Package';

  ScrollController? _controller;
  late GoogleMapController myController;
  List packagelist = [];

  //late LatLng _currentLocation;
  //late Location _location= Location();
  final LatLng _center = const LatLng(26.7915, 75.2100);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> pop() async {
    return true;
  }

  @override
  void initState() {
    print('cabid////////${widget.cabid}');
    print('droplocation////////${widget.droplocation.toString()}');

    /* _location.onLocationChanged.listen((locationData) {
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

        print('currentlocation${_currentLocation.toString()}');
      });
    });*/

    pickuplocation = widget.locationAddlist.join('*');
    pickuplat = widget.pickuplat_list.join(',');
    pickuplang = widget.pickuplong_list.join(',');

    print('locationString/// ${pickuplocation}');
    print('pickuplat/// ${pickuplat}');
    print('pickuplong/// ${pickuplang}');
    _changePackagetext.text = _changepackText;
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: pop,
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  widget.headertext,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                backgroundColor: ColorConstants.AppColorDark),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: Set<Marker>.of(_markers),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),

                  /*   polylines: {
                Polyline(
                    polylineId: PolylineId('route'),
                    color: Colors.blue,
                    width: 5,
                    points: [
                      LatLng(37.7749, -122.4194),
                      LatLng(37.7899, -122.4334),
                      LatLng(37.8005, -122.4357),
                    ])
              },*/

                  /*markers: {
                if (origin != null) origin,
                if (destination != null) destination
              },
              onLongPress: _addmarker,*/
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),

                      Text(
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          ' Delivery :- '),
                      Flexible(child: Text(
                          style: TextStyle(fontSize: 16),
                          '  ${widget.headertext}')),
                    ],
                  ),
                ),
                new Positioned(
                  child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 155,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalSheet(context);
                                      },
                                      child: Container(

                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                                '${_changePackagetext.text}')),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.orange)),
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    child: Center(
                                        child: Text(widget.VhecletypeName)),
                                  ))
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {
                                showPaymentModelSheet(context);
                              },
                              child: Container(
                                color: Colors.white,
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Image.asset(
                                            width: 25,
                                            height: 25,
                                            'assets/images/user.png'),
                                        Text(' Personal'),
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Image.asset(
                                            width: 25,
                                            height: 25,
                                            'assets/images/info.png'),
                                        Text('  Set Payment Method'),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {



                                getBooking();
                              },
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.black,
                                  child: Center(
                                      child: Text(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          'CONFIRM BOOKING')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            )),
      ),
    );
  }

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(26.7915, 75.2100),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  void getData() async {
    print('cabid_confirm${widget.cabid}');

    try {
      FormData formData = FormData.fromMap({
        AppConstants.CABID: widget.cabid,
      });

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.PackageLIST_URL,
          data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          packagelist = response.data['result'] as List;
          print('print lenth${packagelist}');
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }

  void getPackageList() async {
    print('cabid_confirm${widget.cabid}');

    try {
      FormData formData = FormData.fromMap({
        AppConstants.CABID: widget.cabid,
      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.PackageLIST_URL,
          data: formData);

      var resBody = json.decode(response.data);
      final apiResponse = PackageModel.fromJson(resBody);
      if (response.statusCode == 200) {
        setState(() {
          if (apiResponse != null) {
            print('print list inner');
            packagelist = resBody['result'];
            print('print list inner${packagelist}');

            // cabid = cabid
          } else {
            print('print list inner else else');
            //reLoginDialog();
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

  void showModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return createBox(context, state);
          });
        });
  }

  createBox(BuildContext context, StateSetter state) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Colors.orange,
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    width: 50,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      width: 30,
                      child: Container(
                          child: Center(
                        child: Text(
                          'Choose Package',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      )),
                    ),
                  ))
                ],
              ),
            ),
          ),
          _helpItemBuilder()
        ],
      ),
    );
  }

  Widget _helpItemBuilder() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            controller: _controller,
            itemCount: getHelpLength(),
            itemBuilder: _helpitemBuilder,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true));
  }

  Widget _helpitemBuilder(BuildContext context, int index) {
    return InkWell(
        child: GestureDetector(
      onTap: () {
        setState(() {
          packageid = packagelist[index]['id'].toString();
          print('packageid${packageid}');
          _changePackagetext.text = packagelist[index]['hour'].toString() +
              ' Hour ' +
              packagelist[index]['km'].toString() +
              ' KM ' +
              packagelist[index]['price'].toString() +
              ' INR';
          Navigator.of(context).pop();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: ColorConstants.AppColorDark),
          ),
          // color: (index % 2 == 0) ? Colors.white :ColorConstants.AppColorDark,
        ),
        child: Column(
          children: [
            Container(
              //  color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  packagelist[index]['hour'].toString() +
                      ' Hour ' +
                      packagelist[index]['km'].toString() +
                      ' KM ' +
                      packagelist[index]['price'].toString() +
                      ' INR',
                  style: TextStyle(
                      fontSize: 13,
                      color: ColorConstants.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              //  holder.additional.setText("Additional charges for extra distance : "+currency+" "+ride.getAdddist()+"/Km"+
              //         "\nextra time : "+currency+" "+ride.getAddtime()+"/Hr");
              child: Text(
                'Additional charges for extra distance : INR  ${packagelist == null ? "" : packagelist[index]['charge_for_additional_dist'].toString() + '/KM' + '\nextra time : ' + ' INR ' + packagelist[index]['charge_for_additional_time'].toString()}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  int getHelpLength() {
    if (packagelist.isNotEmpty) {
      return packagelist.length;
    } else {
      return 0;
    }
  }


  void cancelRide() async {
    preferences = await SharedPreferences.getInstance();

    try {
      FormData formData = FormData.fromMap({

        AppConstants.Rideid: widget.ride_id,


      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.CancelRide_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          //cablist = response.data['result'][0]['cabtypes'] as List;

          var resut= response.data['result'][0]['Result'];
          print('print response${response.data['result'][0]['Result']}');
          if(response.data['result'][0]['Result'] == 'Ride cancelled successfully'){
            Fluttertoast.showToast(
                msg: 'Ride cancelled successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white);
            Navigator.pop(context);
          }else{
            Fluttertoast.showToast(
                msg: 'Something went Wrong',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
          /* if(resut=='Login success'){
            preferences.setString("userid", response.data['result'][0]['userid']);
            preferences.setString("uid", response.data['result'][0]['uid']);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          }else{
            print('Please Enter Valid Details');
          }*/


          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }

  void getBooking() async {
    preferences = await SharedPreferences.getInstance();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss aa');
    String currentDate = formatter.format(now);
    print(currentDate); // 2016-01-25
    print('currentDate${currentDate}');
    print('PickupLocation${pickuplocation}');
    print('droplocation${widget.droplocation}');
    print('pickuplat${pickuplat}');
    print('pickuplang${pickuplang}');
    print('droplat${widget.droplat}');
    print('droplong${widget.droplong}');
    print('packageid${packageid}');
    print('UID${preferences.getString('userid')}');
    print('CabType${widget.cabid}');
    print('PayType${pay_type_}');

    try {
      FormData formData = FormData.fromMap({
        AppConstants.Ridedate: currentDate,
        AppConstants.ReturnDate: '00-00-0000 00:00:00 am',
        AppConstants.PickupLocation: pickuplocation,
        AppConstants.DropLocation: widget.droplocation,
        AppConstants.PickLat: pickuplat,
        AppConstants.PickLng: pickuplang,
        AppConstants.DropLatLong: widget.droplat + ',' + widget.droplong,
        AppConstants.Package: packageid,
        AppConstants.UserId: preferences.getString('userid'),
        AppConstants.CabType: widget.cabid,
        AppConstants.PayType: pay_type_,
      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.Booking_URL,
          data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //{result: [{Result: No money, ride_id: , status: 0, msg: Insufficient balance in your wallet! please add  money in your wallet.}]}
          print('print response   ${response.data.toString()}');
          var resut = response.data['result'][0]['Result'];
          print('print response${resut.toString()}');
          if (resut != null) {
            if(response.data['result'][0]['status'].toString() == '0'){
              showCustomDialog(context, message: response.data['result'][0]['msg'].toString(), status: response.data['result'][0]['status'].toString());

            }
            print('print response${resut.toString()}');
            // print('responcedata////  ${response.data['result']}');
          }else{
            showCustomDialog(context,
                message: response.data['result'][0]['msg'].toString(), status:  response.data['result'][0]['status'].toString());
          }

          // var resut = response.data['result'][0]['Result'];


         // Navigator.pop(context);
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }
  static void showCustomDialog(BuildContext context, {required String message,required String status, String okBtnText = "Ok",}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if(status == '0'){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletScreen()));
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text(okBtnText),
                //  onPressed: okBtnFunction,
              ),

            ],
          );
        });
  }


  void showPaymentModelSheet(BuildContext context) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return createBoxPayment(context, state);
          });
        });
  }

  createBoxPayment(BuildContext context, StateSetter state) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Colors.orange,
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    width: 50,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      width: 30,
                      child: Container(
                          child: Center(
                        child: Text(
                          'How would you like to pay?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ))
                ],
              ),
            ),
          ),
          _helpitemBuilderPayment(context)
        ],
      ),
    );
  }

  Widget _helpitemBuilderPayment(BuildContext context) {
    return InkWell(
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 2.0, color: ColorConstants.AppColorDark),
              ),
              // color: (index % 2 == 0) ? Colors.white :ColorConstants.AppColorDark,
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter myState) {
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '  Choose Payment Option ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: const Text('Wallet payment'),
                          leading: Radio<PayTypeData>(
                            value: PayTypeData.Wallet,
                            groupValue: pay_type,
                            onChanged: (PayTypeData? value) {
                              myState(() {
                                pay_type = PayTypeData.Wallet;
                                pay_type_ = '0';
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Online'),
                          leading: Radio<PayTypeData>(
                            value: PayTypeData.Online,
                            groupValue: pay_type,
                            onChanged: (PayTypeData? value) {
                              myState(() {
                                pay_type = PayTypeData.Online;
                                pay_type_ = '1';
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Cash'),
                          leading: Radio<PayTypeData>(
                            value: PayTypeData.Cash,
                            groupValue: pay_type,
                            onChanged: (PayTypeData? value) {
                              myState(() {
                                pay_type = PayTypeData.Cash;
                                pay_type_ = '2';
                              });
                            },
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                                width: 25,
                                height: 25,
                                'assets/images/walletnew.png'),
                            /*  Text(
                      ' Wallet payment ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    ),*/
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '  Balence is INR 0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.black12,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                ' Your wallet amount was too low. To user this \n payment method please add money to your wallet.',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.green,
                                    width: 100,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      'Add Money',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    )),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    color: Colors.red,
                                    width: 100,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        /* Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                              width: 25, height: 25, 'assets/images/walletnew.png'),
                          Text(
                            ' Online payment ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                              width: 25, height: 25, 'assets/images/walletnew.png'),
                          Text(
                            ' Case',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),*/

                        Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              color: Colors.black,
                              width: 100,
                              height: 50,
                              child: Center(
                                  child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              );
            })));
  }

  int getPaymentLength() {
    if (packagelist.isNotEmpty) {
      return packagelist.length;
    } else {
      return 0;
    }
  }
}

enum PayTypeData { Wallet, Online, Cash }
