import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class MyBookingDetail extends StatefulWidget {
  final String logo_url;
  final String ride_date;
  final String ride_status;
  final String cabtype;
  final String ride_id;
  final String pickup_location;
  final String profile_url;
  final String estimate_amount;
  final String otp;
  final String driver_name;
  final String drop_location;

  const MyBookingDetail({
    Key? key,
    required this.logo_url,
    required this.ride_date,
    required this.ride_status,
    required this.cabtype,
    required this.ride_id,
    required this.pickup_location,
    required this.profile_url,
    required this.estimate_amount,
    required this.otp,
    required this.driver_name,
    required this.drop_location,
  }) : super(key: key);

  @override
  State<MyBookingDetail> createState() => _MyBookingDetailState();
}

class _MyBookingDetailState extends State<MyBookingDetail> {
  final LatLng _center = const LatLng(26.7915, 75.2100);
  late GoogleMapController myController;
  late SharedPreferences preferences;
  List rideList_list = [];
  List rideList_list_detail = [];
  final List<Marker> _markers = <Marker>[];
  bool isLoading = true;
  var rateTV;
  late String droplat;
  late String droplongi;
  bool cancelride=false;
  bool trackride=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
if(widget.ride_status=='3'){
  cancelride = false;
  trackride = false;
}else if(widget.ride_status=='2'){
  cancelride = false;
  trackride = false;
}else if(widget.ride_status=='1'){
  cancelride = false;
  trackride = false;
}else if(widget.ride_status=='0'){
  cancelride = true;
  trackride = false;
}else if(widget.ride_status=='4'||widget.ride_status=='5'||widget.ride_status=='6'){
  cancelride = false;
  trackride = true;
}


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'My Booking',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            backgroundColor: ColorConstants.AppColorDark),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: 200,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    markers: Set<Marker>.of(_markers),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 15.0,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(widget.profile_url,
                              width: 80, height: 60, fit: BoxFit.fill),
                          Text(
                            widget.driver_name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Image.asset(
                            widget.ride_status == '3'
                                ? 'assets/images/cancelled.png'
                                : widget.ride_status == '2'
                                    ? 'assets/images/tint_finish.png'
                                    : widget.ride_status == '1'
                                        ? 'assets/images/accept.png'
                                        : widget.ride_status == '0'
                                            ? 'assets/images/pending_new.png'
                                            : widget.ride_status == '4'
                                                ? 'assets/images/accept.png'
                                                : widget.ride_status == '5'
                                                    ? 'assets/images/accept.png'
                                                    : widget.ride_status == '6'
                                                        ? 'assets/images/accept.png'
                                                        : '',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(widget.logo_url,
                                width: 80, height: 60, fit: BoxFit.fill),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.ride_date,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                                width: 50,
                                height: 50,
                                'assets/images/rateimg.png'),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              rateTV == null ? '' : rateTV,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                                width: 50,
                                height: 50,
                                'assets/images/address.png'),
                            SizedBox(
                              width: 50,
                            ),
                            Flexible(
                              child: Text(
                                widget.drop_location,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            )
                            ,
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pickup Locations',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: isLoading == true
                            ? Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.deepOrange,
                                size: 40,
                              ))
                            : ListView.builder(
                                itemCount: getLengthDetails(),
                                // list item builder
                                itemBuilder: _itemBuilderDetail,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            width: 40,
                            height: 40,
                            'assets/images/tracking.png'),
                        Text(
                          'TRACKING',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: trackride==true?Colors.white:Colors.grey.shade300),
                        )
                      ],
                    )),
                    VerticalDivider(
                      width: 1,
                      color: Colors.white,
                    ),


                    GestureDetector(

                      onTap: (){
                        cancelride==true?
                        cancelRide() : null;
                      },
                      child:   Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  width: 40,
                                  height: 40,
                                  'assets/images/cancelwhite.png'),
                              Text(
                                'CANCEL',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: cancelride==true?Colors.white:Colors.grey.shade300),
                              )
                            ],
                          )),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            width: 40,
                            height: 40,
                            'assets/images/supportwhite.png'),
                        Text(
                          'SUPPORT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )

/* if(ridestatus.equals("3")){
            img_cancel.setImageResource(R.drawable.cancelled);
            btcancel.setEnabled(false);
            btn_track.setEnabled(false);
        }else if(ridestatus.equals("2")){
            img_cancel.setImageResource(R.drawable.tint_finish);
            btcancel.setEnabled(false);
            btn_track.setEnabled(false);
        }else if(ridestatus.equals("1")) {
            img_cancel.setImageResource(R.drawable.accept);
            btcancel.setEnabled(false);
            btn_track.setEnabled(false);
        }else if(ridestatus.equals("0")) {
            img_cancel.setImageResource(R.drawable.pending_new);
            btcancel.setEnabled(true);
            btn_track.setEnabled(false);
        }else if(ridestatus.equals("4") || ridestatus.equals("5") || ridestatus.equals("6")){
            btcancel.setEnabled(false);
            img_cancel.setImageResource(R.drawable.accept);
            btn_track.setEnabled(true);
        }*/
          ],
        ));
  }

  int getLengthDetails() {
    if (rideList_list_detail.isNotEmpty) {
      print("lenght of list ${rideList_list_detail.length}");
      return rideList_list_detail.length;
    } else {
      return 0;
    }
  }

  Widget _itemBuilderDetail(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: InkWell(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                      child: Center(
                          child: Text(rideList_list_detail == null
                              ? ""
                              : (index + 1).toString())),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    Flexible(child: Text(
                      rideList_list_detail[index]['ride_location'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    )),

                    SizedBox(
                      width: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
  void cancelRide() async {
    print('cancel ride${widget.ride_id}');
    preferences = await SharedPreferences.getInstance();

    try {
      FormData formData = FormData.fromMap({

        AppConstants.Ride_id: widget.ride_id,


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

  void getData() async {


    preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({
        AppConstants.Rideid: widget.ride_id,
      });

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.MyRidesDetails_URL,
          data: formData);
      if (response.statusCode == 200) {

        setState(() {
          isLoading = false;
        });
        setState(() async {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          rideList_list = response.data['result'] as List;
          rideList_list_detail = response.data['result'][1]['ridelist'] as List;
          print('ridedetaillist${rideList_list_detail.toString()}');
          rateTV = response.data['result'][0]['ride'][0]['hour'] +
              ' Hr ' +
              response.data['result'][0]['ride'][0]['km'] +
              ' Km ' +
              response.data['result'][0]['ride'][0]['price'];
          print(rateTV);
          droplat = rideList_list[0]['drop_lat'].toString();
          droplongi = rideList_list[0]['drop_long'].toString();

          //_center=LatLng(droplat as double, droplongi);
          //  tvprice.setText(eve1.getString("hour")+" Hr "+eve1.getString("km")+" Km "+eve1.getString("price")+" "+currency);

          loadData();

          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }

      // print(response);
    } catch (e) {
      print(e);
    }
  }

  loadData() async {
    for (int i = 0; i < rideList_list_detail.length; i++) {
      //final Uint8List markIcons = await getImages(MarkerListData[i].images, 100);
      // makers added according to index
      print('pickup_lat${rideList_list_detail[i]['pickup_lat'].toString()}');
      _markers.add(Marker(
          // given marker id
          //icon: BitmapDescriptor.fromBytes(markIcons),

          markerId: MarkerId(i.toString()),
          position: LatLng(
              double.parse(rideList_list_detail[i]['pickup_lat'].toString()),
              double.parse(rideList_list_detail[i]['pickup_lng'].toString())),
          infoWindow: InfoWindow(
            title: 'My Position',
          )));
      setState(() {
        EasyLoading.dismiss();
      });
    }
  }
/*  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(26.7915, 75.2100),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];*/
}
