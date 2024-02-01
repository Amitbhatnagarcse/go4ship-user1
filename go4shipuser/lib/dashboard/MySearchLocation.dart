import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';

class MySearchLocation extends StatefulWidget {

  const MySearchLocation({super.key});


  @override
  State<MySearchLocation> createState() => _MySearchLocationState();
}

class _MySearchLocationState extends State<MySearchLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar( title: Text('Search'),),
      body: SingleChildScrollView(
        child: SearchLocation(apiKey: 'AIzaSyDykH9xQyiVNxoaLIMQyIz7Nk--gOZD-8w',
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
            getCoordinatesFromAddress(description);
          },
        ),
      ),
    );
  }
  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations != null && locations.isNotEmpty) {
        Location first = locations.first;
        double latitude = first.latitude;
        double longitude = first.longitude;
        print('Latitude: $latitude, Longitude: $longitude');
      } else {
        print('No location found for the provided address.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
