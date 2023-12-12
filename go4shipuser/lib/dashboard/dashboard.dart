import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go4shipuser/confirmRideScreen/confirm_screen.dart';

import 'package:go4shipuser/constant/AppColor.dart';
import 'package:go4shipuser/dashboard/Model/CabListModel.dart';
import 'package:go4shipuser/dashboard/MySearchLocation.dart';
import 'package:go4shipuser/ratecard/ratecard.dart';
import 'package:go4shipuser/support/support.dart';
import 'package:go4shipuser/walletscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:search_map_location/search_map_location.dart';

import 'package:share_plus/share_plus.dart';
import '../constant/AppUrl.dart';
import '../profile/myprofile.dart';
import 'category_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Completer<GoogleMapController> _controllerCompleter = Completer();
  late GoogleMapController myController;
  late Marker origin;
  late Marker destination;
  ScrollController? _controller;
  late Dialog dialog;
  final LatLng _center = const LatLng(26.7915, 75.2100);
  int selectedIndex = 0; //will highlight first item
  //List<PlacesSearchResult> places = [];
  List cablist = [];
  List locationAddlist = [];
  int selectedindex = 0;

  //var cablistdata;
  String? _currentAddress;
  Position? _currentPosition;
  String? cabid;
  String? HeaderText;

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
                      leading: Icon(Icons.home, color: ColorConstants.black),
                      title: Text('Book your delivery'),
                      onTap: () {
                        // Navigator.pop(context); // Close the drawer

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: ColorConstants.black),
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
                      leading:
                          Icon(Icons.watch_later, color: ColorConstants.black),
                      title: Text('My Bookings'),
                      onTap: () {
                        //Navigator.pop(context); // Close the drawer

                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.wallet, color: ColorConstants.black),
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
                      leading:
                          Icon(Icons.discount, color: ColorConstants.black),
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
                      leading: Icon(Icons.support, color: ColorConstants.black),
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
                      leading: Icon(Icons.share, color: ColorConstants.black),
                      title: Text('Share App'),
                      onTap: () {
                        //Navigator.pop(context); // Close the drawer

                        Share.share(
                            'Hi,I would like to share Application which is used to get more rides &amp; more income. Please download it from Google Play Store Free Here \n https://play.google.com/store/apps/details?id=com.go4ship.user');
                        // Add navigation logic here
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: ColorConstants.black),
                      title: Text('Logout'),
                      onTap: () {
                        // Navigator.pop(context); // Close the drawer

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
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(style: TextStyle(color: Colors.black),'Book Your Delivery'),
          backgroundColor: ColorConstants.AppColorDark,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(_markers),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
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
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getLength(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedindex = index);
                            cabid = cablist[index]['id'];
                            HeaderText = cablist[index]['cabtype'];
                            print('cabid_Click${cablist[index]['id']}');
                            //swapitems(selectedIndex);
                            selectedIndex = 0;
                            //cabid = cablist[index]['id'];
                            //print('cabid_Click${cablist[index]['id']}');

                            //swapitems(selectedindex),
                            //selectedindex=0,
                            //_selected[index] = !_selected[index]);
                          },
                          child: CategoryIcons(
                            iconColor: selectedindex == index
                                ? ColorConstants.AppColorLightShadow
                                : Colors.white,
                            title: cablist[index]['cabtype'],
                            icon: cablist[index]['logo_url'],
                          ),
                        );
                      },
                    )),
                /*     Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                  color: Colors.white,
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getLength(),
                    // list item builder
                    itemBuilder: _itemBuilder,
                  )),*/

                GestureDetector(
                  onTap: () async {
                    /* Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MySearchLocation()));*/

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MySearchLocation()),
                    ).then((value) => setState(() {
                          print('statechange1------$value');

                          if (value != null) {
                            locationAddlist.add('${value}');
                          }
                        }));

                    /* final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MySearchLocation(),
                        )
                    );*/

                    /* setState(() async {
                      //print('resultBack;------------${result}');
                      // text = result;
                      //locationAddlist.add( await result.geolocation);
                      locationAddlist.add('${result}');
                      // print('listlenth:-------${locationAddlist.length}');
                      // final geolocation = await result.geolocation;
                      // final GoogleMapController controller = await myController.future;
                      //  myController.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                      //myController.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                    });*/
                  },
                  child: Container(
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
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () async {
                        /* Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MySearchLocation()));*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MySearchLocation()),
                        ).then((value) => setState(() {
                              print('statechange1$value');
                              if (value != null) {
                                locationAddlist.add('${value}');
                              }
                            }));
                      },
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
                    )),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: getAddLocationLength(),
                      itemBuilder: _addLocationitemBuilder),
                ),
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
                        child: GestureDetector(
                      onTap: () {
                        // openAlert();
                      },
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
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmScreen(cabid: cabid.toString(),headertext: HeaderText.toString(),)));
                          },
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openAlert() {
    dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 350.0,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16),
              //decoration: boxDecorationStylealert,
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile no.',
                            hintText: 'Enter valid 10 digit mobile no.'),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter your secure password'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, right: 6),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 6, right: 12),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: Text(
                        "OK",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _getCurrentPosition();

    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());

      // marker added for current users location
      _markers.add(Marker(
        markerId: MarkerId("2"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: InfoWindow(
          title: 'My Current Location',
        ),
      ));

      // specified current users location
      CameraPosition cameraPosition = new CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controllerCompleter.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
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



       // cabid = cabid
      } else {
        //reLoginDialog();
      }
    });
    //dismiss loader
    // await EasyLoading.dismiss();
    return "Success";
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Wrap(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }

  int getLength() {
    if (cablist.isNotEmpty) {
      return cablist.length;
    } else {
      return 0;
    }
  }

  int getAddLocationLength() {
    if (locationAddlist.isNotEmpty) {
      return locationAddlist.length;
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

  Widget _addLocationitemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        height: 50,
        width: double.infinity,
        child: Card(
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text('${index + 1}')),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                locationAddlist[index],
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print('lenthremove}');
                    locationAddlist.removeAt(index);
                  });

                  // locationAddlist.remove(index);
                },
                child: Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                        width: 16, height: 16, 'assets/images/cancel.png'),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void swapitems(int index) {
    String temp;
    temp = cablist[index];
    cablist[index] = cablist[0];
    cablist[0] = temp;
  }

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(26.7915, 75.2100),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
