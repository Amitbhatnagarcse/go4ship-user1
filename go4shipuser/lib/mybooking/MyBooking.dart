import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  List rideList_list = [];
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('My Bookings'), backgroundColor: ColorConstants.AppColorDark),

        body: Column(
          children: [

            Expanded(child:  ListView.builder(
              itemCount: getLength(),
              // list item builder
              itemBuilder: _itemBuilder,
            ))
          ],
        )
    );
  }
  void getData() async {
    try {
      var response = await Dio().get(AppConstants.app_base_url + AppConstants.MyRides_URL);
      if (response.statusCode == 200) {
        setState(() {

       //   print(object)
          rideList_list = response.data['result'] as List;
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }

  int getLength() {
    if (rideList_list.isNotEmpty) {
      print("lenght of list ${rideList_list.length}");
      return rideList_list.length;
    } else {
      return 0;
    }
  }
  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${rideList_list[index]['ride_id'].toString().trim()}',
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),

            SizedBox(height: 10,),
           /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // 'nqjkabfkbajebfjhsbdjh',
                '${rideList_list == null ? "" : rideList_list[index]['ans'].toString().trim()}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),

              ),
            ),
            SizedBox(height: 10,),
            Divider(
              color: Colors.black,
              height: 2,
            )*/

          ],
        ),

      ),
    );
  }
}
