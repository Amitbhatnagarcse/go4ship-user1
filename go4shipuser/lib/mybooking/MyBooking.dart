import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/mybooking/MyBookingDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  late SharedPreferences preferences;
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
            title: Text('My Bookings'),
            backgroundColor: ColorConstants.AppColorDark),
        body: GestureDetector(
          onTap: (){

          },
          child:  Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    itemCount: getLength(),
                    // list item builder
                    itemBuilder: _itemBuilder,
                  ))
            ],
          )),
        );
  }

  void getData() async {
    preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({
        AppConstants.UserId: preferences.getString('userid'),
      });

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.MyRides_URL,
          data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          rideList_list = response.data['result'] as List;
          print('print lenth${rideList_list}');
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
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
    return
    GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => MyBookingDetail(logo_url: rideList_list[index]['logo_url'].toString(), ride_date: rideList_list[index]['ride_date'].toString(), ride_status: rideList_list[index]['ride_status'].toString(), cabtype: rideList_list[index]['cabtype'].toString(), ride_id: rideList_list[index]['ride_id'].toString(), pickup_location: rideList_list[index]['pickup_location'].toString(), profile_url: rideList_list[index]['profile_url'].toString(), estimate_amount: rideList_list[index]['estimate_amount'].toString(), otp: rideList_list[index]['otp'].toString(), driver_name: rideList_list[index]['driver_name'].toString(),)));
      },
      child: InkWell(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 1,
                  ),
                  Image.network(rideList_list[index]['logo_url'],
                      width: 40, height: 40, fit: BoxFit.fill),
                  Text(
                    rideList_list[index]['ride_date'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  Text(
                    rideList_list[index]['ride_status'] == '2'
                        ? 'Finished'
                        : rideList_list[index]['ride_status'] == '1'
                        ? 'Accepted'
                        : rideList_list[index]['ride_status'] == '4'
                        ? 'In Progress'
                        : rideList_list[index]['ride_status'] == '5'
                        ? 'On the Way'
                        : rideList_list[index]['ride_status'] == '6'
                        ? 'On Ride'
                        : rideList_list[index]['ride_status'] ==
                        '3'
                        ? 'Cancelled'
                        : rideList_list[index]
                    ['ride_status'] ==
                        '0'
                        ? 'Pending'
                        : '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: rideList_list[index]['ride_status'] == '2'
                          ? Colors.green
                          : rideList_list[index]['ride_status'] == '1'
                          ? Colors.purple
                          : rideList_list[index]['ride_status'] == '4'
                          ? Colors.purple
                          : rideList_list[index]['ride_status'] == '5'
                          ? Colors.purple
                          : rideList_list[index]['ride_status'] == '6'
                          ? Colors.purple
                          : rideList_list[index]['ride_status'] ==
                          '3'
                          ? Colors.grey
                          : rideList_list[index]
                      ['ride_status'] ==
                          '0'
                          ? Colors.blueAccent
                          : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    rideList_list[index]['cabtype']+' :- ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  Text(
                    rideList_list[index]['ride_id'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                              child: Container(
                                  height: 10, width: 10, color: Colors.orange)),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              rideList_list[index]['pickup_location'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                              child: Container(
                                  height: 10, width: 10, color: Colors.orange)),

                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            rideList_list[index]['count'] + ' locations',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                  Image.network(rideList_list[index]['profile_url'],
                      width: 80, height: 60, fit: BoxFit.fill),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '  INR ' + rideList_list[index]['estimate_amount'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green),
                  ),
                  Text(
                    'OTP ' + rideList_list[index]['otp'].toString() + '  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    )
    ;
  }
}
