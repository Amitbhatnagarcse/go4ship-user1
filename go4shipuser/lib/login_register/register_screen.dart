import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/login_register/login_screen.dart';
import 'package:go4shipuser/FCMClasses/notification_service.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  NotificationServices notificationServices = NotificationServices();
  List city_list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.getToken().then((value) {
      print('Device token');
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(

              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorConstants.AppColorDark,
                    ColorConstants.AppColorPrimary,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(5.0, 5.0),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                  border: Border.all()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                        width: 80, height: 80, 'assets/images/go4ship_logo.png'),
                  ),
                  Text(
                      style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                      "Register")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [

                Container(

                  child: Row(
                    children: [
                      Expanded(child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mobile no.',
                              hintText: 'Enter valid 10 digit mobile no.'),
                        ),
                      ),),

                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 20),
                        child: GestureDetector(
                          onTap: () {


                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorConstants.AppColorDark,
                            ),
                            child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white,fontSize: 18),
                                'Get Otp')),
                          ),
                        ),
                      )


                    ],
                  ),
                 /* child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile no.',
                          hintText: 'Enter valid 10 digit mobile no.'),
                    ),
                  ),*/
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'OTP',
                          hintText: 'Enter valid OTP'),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your secure password'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.only(left: 20),
                  width: 225,
                  color: Colors.grey.shade200,
                 /* child: DropdownButton(
                    value: dropdownValue,
                    items: city_list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),*/
                ),


                Container(
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Do you have any refer no.',
                          hintText: 'Do you have any refer no.'),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorConstants.AppColorDark,
                ),
                child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white,fontSize: 18),
                    'Register')),
              ),
            ),
            SizedBox(
              height: 50,
            ),

            GestureDetector(
             onTap: (){
               print("click on tap");
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context) => LoginScreen()));
             },

              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account?"),
                  ),
                  Container(
                    child: Text(style: TextStyle(decoration: TextDecoration.underline,fontWeight:FontWeight.bold,color: Colors.deepOrange)," Sign in"),
                  ),
                ],

              ),
            ),

          ],
        ),
      ),
    );
  }

  void getCityList() async {

    try {
      FormData formData = FormData.fromMap({

        AppConstants.STATE: '2853',

      });

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.CITYLIST_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {

          var resut= response.data['result'][0]['Result'];
          print('print response${resut}');
          //city_list=resut.
        });
      }
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
