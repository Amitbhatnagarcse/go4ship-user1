import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194), // Initial map center (San Francisco, CA)
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              // Do something with the controller if needed
            },
          ),
          MarkerLayer(),
        ],
      ),
    );
  }
}

class MarkerLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MarkerWidget(position: LatLng(37.7749, -122.4194), key: null,), // Example marker
            // Add more MarkerWidgets as needed for other markers
          ],
        ),
      ),
    );
  }
}

class MarkerWidget extends StatelessWidget {
  final LatLng position;

  const MarkerWidget({ Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Icon(
        Icons.location_on,
        size: 36,
        color: Colors.red,
      ),
    );
  }
}
