import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go4shipuser/constant/AppColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';

class MySearchLocation extends StatefulWidget {
  const MySearchLocation({super.key});

  @override
  State<MySearchLocation> createState() => _MySearchLocationState();
}

class _MySearchLocationState extends State<MySearchLocation> {
  late GoogleMapController mapcontroller;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(26.912434, 75.787270), zoom: 14);
  late CameraPosition cameraPosition;
  String _latitude = 'Unknown';
  String _longitude = 'Unknown';
  String location1 = "Location Name:";
  LatLng _center = const LatLng(26.912434, 75.787270);
  String? _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorConstants.AppColorDark,
          title: Text('Search'),
        ),
        body: Stack(children: <Widget>[
          GestureDetector(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  mapcontroller = controller;
                });
              },
              initialCameraPosition: initialCameraPosition,
              onCameraIdle: () async {
                getaddress();
                //_getLocation();
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },
              onTap: _handleTap,
            ),
          ),
          Center(
            child: Image.asset(
                fit: BoxFit.fill,
                width: 30,
                height: 30,
                'assets/images/pin.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
              child: Center(
                child: SearchLocation(
                  apiKey: 'AIzaSyDykH9xQyiVNxoaLIMQyIz7Nk--gOZD-8w',
                  country: 'IN',
                  language: 'en',
                  onSelected: (Place place) async {
                    final description = await place.description;
                    final geolocation = await place.geolocation;
                    final placeId = await place.placeId;
                    final fullJSON = await place.fullJSON;
                    // final lat = await place.;

                    print('description:::::------${description}');
                    print('latlong:::::------${geolocation!.coordinates}');
                    print('placeId:::::------${placeId}');
                    print('fullJSON:::::------${fullJSON}');

                    Navigator.pop(context, description);
                    //getCoordinatesFromAddress(description);
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Text(_currentAddress.toString()== 'null'?'':_currentAddress.toString(),style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context,_currentAddress.toString());
                      },
                      child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 2,top: 5),
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                    height: 45,
                    child: Center(
                        child: Text(
                      'Add Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  void _handleTap(LatLng tappedPoint) {
    print(
        'tappedPoint /// ${tappedPoint}'); // This prints the tapped point coordinates
    // You can do further processing with the tapped coordinates here
    _center = LatLng(tappedPoint.latitude, tappedPoint.longitude);
    print('latlongInit /// ${tappedPoint.latitude + tappedPoint.latitude}');
    //_deliveryLocation.text = 'Delivery Location';
  }

  Future<void> getaddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        cameraPosition.target.latitude,
        cameraPosition.target.longitude);

    setState(() {
      //get place name from lat and lang
      location1 = placemarks.first.administrativeArea.toString() +
          ", " +
          placemarks.first.subLocality.toString();
      print('placemarks${placemarks.toString()}');
      _currentAddress =
          '${placemarks.first.locality}, ${placemarks.first.subLocality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.postalCode}';
      print('_currentAddress${_currentAddress.toString()}');
      _currentAddress = _currentAddress.toString();
       _getLocation();
    });
  }
  void _getLocation() async {


    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {

        _center = LatLng(position.latitude, position.longitude);

        _handleTap;

        cameraPosition = CameraPosition(
          target: LatLng(double.parse(_latitude)  ,  double.parse(_longitude)),
          zoom: 17,
        );
      });

    } catch (e) {
      print("Error: $e");
    }
    //getData();
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
