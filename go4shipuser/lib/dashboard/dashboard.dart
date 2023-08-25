import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/walletscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final LatLng _center = const LatLng(37.7749, -122.4194);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        drawer: Drawer(
          child:  ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(

                child: Image.asset(
                    fit: BoxFit.fill,
                    width: double.infinity, height: 40, 'assets/images/navhead.jpg'),
              ),
              SizedBox(
                height: 10,
              ),

              Text( style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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

                leading: Icon(Icons.home, color: Colors.orange),

                title: Text('Book your delivery'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

              ListTile(

                leading: Icon(Icons.person, color: Colors.orange),

                title: Text('My Profile'),

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyProfile()));


                 // Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

              ListTile(

                leading: Icon(Icons.watch_later, color: Colors.orange),

                title: Text('My Bookings'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

              ListTile(

                leading: Icon(Icons.wallet, color: Colors.orange),

                title: Text('My Wallet'),

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WalletScreen()));

                  // Add navigation logic here
                },
              ),

              Divider(
                color: Colors.black,
                height: 3,
              ),

              ListTile(

                leading: Icon(Icons.discount, color: Colors.orange),

                title: Text('Rate Card'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

              ListTile(

                leading: Icon(Icons.support, color: Colors.orange),

                title: Text('Support'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),
              ListTile(

                leading: Icon(Icons.share, color: Colors.orange),

                title: Text('Share App'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

              ListTile(

                leading: Icon(Icons.logout, color: Colors.orange),

                title: Text('Logout'),

                onTap: () {

                  Navigator.pop(context); // Close the drawer

                  // Add navigation logic here
                },
              ),

            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Flutter Maps Demo'),
          backgroundColor: Colors.green,
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
              ),polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.blue,
                  width: 5,
                  points: [
                    LatLng(37.7749, -122.4194),
                    LatLng(37.7899, -122.4334),
                    LatLng(37.8005, -122.4357),
                  ]
                )
            },


              /*markers: {
                if (origin != null) origin,
                if (destination != null) destination
              },
              onLongPress: _addmarker,*/
            ),




            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () => print('You have pressed the button'),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
