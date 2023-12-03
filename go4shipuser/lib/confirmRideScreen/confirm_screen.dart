import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/confirmRideScreen/PackageModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class ConfirmScreen extends StatefulWidget {
  final String cabid;

  const ConfirmScreen({
    Key? key,
    required this.cabid,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  ScrollController? _controller;
  late GoogleMapController myController;
  List packagelist = [];
  
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
            Container(
              margin: EdgeInsets.only(top: 30),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ' Delivery'),
                  Text(style: TextStyle(fontSize: 16), ''),
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
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ColorConstants.AppColorDark,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 25,
                                        child: Center(
                                            child: Text('Select Package')),
                                      )),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.orange)),
                                margin: EdgeInsets.all(5),
                                height: 25,
                                child: Center(child: Text('Auto Rickshaw')),
                              ))
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
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
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Align(
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

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.PackageLIST_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          packagelist = response.data['result'][0]['cabtypes'] as List;
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

  //Show Help Desk
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
                          'Help Desk',
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
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 2.0, color: ColorConstants.AppColorLight),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'कार्यालय का समय (${''})',
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.AppColorPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          _helpItemBuilder()
        ],
      ),
    );
  }
 Widget _helpItemBuilder(){
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            controller: _controller,
            itemCount: getHelpLength(),
            itemBuilder: _helpitemBuilder,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true
        )
    );
  }
  Widget _helpitemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: ColorConstants.AppColorDark),
          ),
          color: (index % 2 == 0) ? Colors.white :ColorConstants.AppColorDark,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      //  color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          packagelist[index]['price'].toString(),
                          style: TextStyle(
                              fontSize: 13,
                              color: ColorConstants.AppColorPrimary,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${packagelist == null ? "" : packagelist[index]['hour'].toString()}',
                    style: TextStyle(fontSize: 13,color:Colors.black,fontWeight: FontWeight.normal),),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  int getHelpLength() {
    if(packagelist.isNotEmpty){
      return packagelist.length;
    }else{
      return 0;
    }
  }
}
