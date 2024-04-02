import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go4shipuser/FCMClasses/notification_service.dart';
import 'package:go4shipuser/dashboard/dashboard.dart';
import 'package:go4shipuser/login_register/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';
import '../constant/DialogUtils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  NotificationServices notificationServices = NotificationServices();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _passwordcontroller= TextEditingController();
  var fcmtoken ='';
  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.getToken().then((value) {
      fcmtoken = value;
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
                    ColorConstants.AppColorLight,
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
                      "Login")
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Column(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _phonecontroller,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile no.',
                          hintText: 'Enter valid 10 digit mobile no.'),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your secure password'),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 50,
            ),

            GestureDetector(
              onTap: () {

               ValidData();
                //BaseflowPluginExample();



              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorConstants.AppColorDark,
                ),
                child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white,fontSize: 18),
                    'Login')),
              ),
            ),
            SizedBox(
              height: 50,
            ),

            GestureDetector(
              onTap: () {
                print("click on tap");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                  ),
                  Container(
                    child: Text(style: TextStyle(fontSize:15,decoration: TextDecoration.underline,fontWeight:FontWeight.bold,color: ColorConstants.AppColorDark)," Sign up"),
                  ),
                ],

              ) ,
            )


          ],
        ),
      ),
    );
  }

  void getLoginData() async {
     await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    print('emial${_phonecontroller.text.toString()}');
    print('password${_passwordcontroller.text.toString()}');
    print('FCM_TOKEN${fcmtoken}');
    preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({

        AppConstants.UMAIL: _phonecontroller.text.toString(),
        AppConstants.UPWDd: _passwordcontroller.text.toString(),
        AppConstants.FCM_TOKEN: fcmtoken,
      });
      //response = await dio.post("/info", data: formData);
     // print(“Response FormData :: ${formData}”);

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.USERLOGIN_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          //cablist = response.data['result'][0]['cabtypes'] as List;

          var resut= response.data['result'][0]['Result'];
          print('print response${resut}');
          if(resut=='Login success'){
            preferences.setString("userid", response.data['result'][0]['userid']);
            preferences.setString("uid", response.data['result'][0]['uid']);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          }else{
            DialogUtils.showCustomDialog(context, message: 'Please Enter Valid Details');
            print('Please Enter Valid Details');
          }


          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      await EasyLoading.dismiss();
       print(response);
    } catch (e) {
      await EasyLoading.dismiss();
      print(e);
    }
  }
  void ValidData(){
    if(_phonecontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter phone no.');
    // MyToast.getToast('Please enter phone no.');
    } else if(_phonecontroller.text.toString().length<10){
      DialogUtils.showCustomDialog(context, message: 'Please enter 10 digit phone no.');
      // MyToast.getToast('Please enter phone no.');
    }else if(_passwordcontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter password ');
     // MyToast.getToast('Please enter password ');
    }else{
      getLoginData();
    }
  }
}
