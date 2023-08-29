import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go4shipuser/constant/AppColor.dart';
import 'package:go4shipuser/dashboard/Model/CabListModel.dart';
import 'package:go4shipuser/ratecard/ratecard.dart';
import 'package:go4shipuser/support/support.dart';
import 'package:go4shipuser/walletscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import 'package:share_plus/share_plus.dart';
import '../constant/AppUrl.dart';
import '../profile/myprofile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GoogleMapController myController;
  late Marker origin;
  late Marker destination;
  ScrollController? _controller;
  final LatLng _center = const LatLng(37.7749, -122.4194);
  int selectedIndex = 0; //will highlight first item

  List cablist = [];

  //var cablistdata;

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  //List<String> youList=['1,'2','3','4'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: ColorConstants.light_bluebg,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 40,
                          'assets/images/navhead.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        "  Go4Ship"),
                    Divider(
                      color: Colors.black,
                      height: 3,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 3,
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.home, color: ColorConstants.AppColorDark),
                      title: Text('Book your delivery'),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person,
                          color: ColorConstants.AppColorDark),
                      title: Text('My Profile'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile()));

                        // Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.watch_later,
                          color: ColorConstants.AppColorDark),
                      title: Text('My Bookings'),
                      onTap: () {
                        //Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.wallet,
                          color: ColorConstants.AppColorDark),
                      title: Text('My Wallet'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletScreen()));

                        // Add navigation logic here
                      },
                    ),
                    Divider(
                      color: Colors.black,
                      height: 3,
                    ),
                    ListTile(
                      leading: Icon(Icons.discount,
                          color: ColorConstants.AppColorDark),
                      title: Text('Rate Card'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RateCard()));

                        //Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.support,
                          color: ColorConstants.AppColorDark),
                      title: Text('Support'),
                      onTap: () {
                        // Navigator.pop(context); // Close the drawer
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupportScreen()));
                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.share, color: ColorConstants.AppColorDark),
                      title: Text('Share App'),
                      onTap: () {
                        //Navigator.pop(context); // Close the drawer

                        Share.share('Hi,I would like to share Application which is used to get more rides &amp; more income. Please download it from Google Play Store Free Here \n https://play.google.com/store/apps/details?id=com.go4ship.user');
                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout,
                          color: ColorConstants.AppColorDark),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Flutter Maps Demo'),
          backgroundColor: ColorConstants.AppColorDark,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              polylines: {
                Polyline(
                    polylineId: PolylineId('route'),
                    color: Colors.blue,
                    width: 5,
                    points: [
                      LatLng(37.7749, -122.4194),
                      LatLng(37.7899, -122.4334),
                      LatLng(37.8005, -122.4357),
                    ])
              },

              /*markers: {
                if (origin != null) origin,
                if (destination != null) destination
              },
              onLongPress: _addmarker,*/
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                    color: Colors.white,
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getLength(),
                      // list item builder
                      itemBuilder: _itemBuilder,
                    )),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Image.asset(
                                height: 25, 'assets/images/tarck_others.png'),
                          ),
                        )),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Delivery Location'),
                          ),
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                                height: 20, 'assets/images/map_location.png'),
                          ),
                        )),
                      ],
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 5),
                    width: 180,
                    color: Colors.black,
                    height: 40,
                    child: Center(
                        child: Text(
                            style: TextStyle(color: Colors.white),
                            '+ Add Pickup Location')),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(5),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      height: 50,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'DELIVER LATER'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      height: 50,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'DELIVER NOW'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    //getCabList();
  }

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _addmarker(LatLng pos) {
    if (origin == null || (origin != null && destination != null)) {
      setState(() {
        origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
        // destination= null;
      });
    } else {
      setState(() {
        destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
    }
  }

  Future<String> getCabList() async {
    /* await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );*/
    var response = await post(
        Uri.parse(AppConstants.app_base_url + AppConstants.cablist_Api),
        body: {});
    var resBody = json.decode(response.body);
    final apiResponse = CabListModel.fromJson(resBody);
    setState(() {
      print('print list');
      if (apiResponse != null) {
        print('print list inner');
        cablist = resBody['result'];
        print('print list inner${cablist}');
      } else {
        //reLoginDialog();
      }
    });
    //dismiss loader
    // await EasyLoading.dismiss();
    return "Success";
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        width: 150,
        height: 100,
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.network(cablist[index]['logo_url']),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Text(
                  '${cablist == null ? "" : cablist[index]['cabtype']}',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                )),
              ],
            ),
            VerticalDivider(
              width: 1,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  int getLength() {
    if (cablist.isNotEmpty) {
      return cablist.length;
    } else {
      return 0;
    }
  }

  void getData() async {
    try {
      var response =
          await Dio().get(AppConstants.app_base_url + AppConstants.cablist_Api);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          cablist = response.data['result'][0]['cabtypes'] as List;
          print('print lenth${cablist}');
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }
}
