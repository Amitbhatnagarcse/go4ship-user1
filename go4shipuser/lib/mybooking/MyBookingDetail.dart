import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant/AppColor.dart';

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
  }) : super(key: key);

  @override
  State<MyBookingDetail> createState() => _MyBookingDetailState();
}

class _MyBookingDetailState extends State<MyBookingDetail> {
  final LatLng _center = const LatLng(26.7915, 75.2100);
  late GoogleMapController myController;

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
                          /* CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: icon,
                            height: 50,
                            width: 50,
                            */ /*placeholder: (context, url) =>
                      const Center(
                          child: CircularProgressIndicator(color: Colors.green,)
                      ),*/ /*
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset(
                                'assets/icons/card.png',
                                height: 80,
                                width: 80,
                                color: Colors.green,
                              ),
                            ),
                          )*/

                          Image.network(widget.profile_url,
                              width: 80, height: 60, fit: BoxFit.fill),
                          Text(widget.driver_name,
                              style: TextStyle(
                                color: Colors.black,
                                  fontWeight: FontWeight.bold, fontSize: 15),),
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
                      )
                    ],
                  ),
                )
              ],
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

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
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
