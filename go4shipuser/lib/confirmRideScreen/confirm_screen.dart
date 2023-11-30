import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmScreen extends StatefulWidget {
  final String cabid;
  const ConfirmScreen({Key? key,
    required this.cabid,

  }) : super(key: key);


  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late GoogleMapController myController;
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
                                  child: Container(

                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                height: 25,
                                child: Center(child: Text('Select Package')),
                              )),
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
}
