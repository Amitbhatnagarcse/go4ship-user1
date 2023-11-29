import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

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
          ],
        )
      ),

      ),
    );
  }

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(26.7915, 75.2100),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];
}
