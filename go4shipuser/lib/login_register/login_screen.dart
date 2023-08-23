import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/FCMClasses/notification_service.dart';
import 'package:go4shipuser/login_register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  NotificationServices notificationServices = NotificationServices();

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
                    Colors.deepOrangeAccent,
                    Colors.orange,
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
                        width: 100, height: 100, 'assets/images/applogo.png'),
                  ),
                  Text(
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              onTap: () {},
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepOrangeAccent,
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
                    child: Text(style: TextStyle(decoration: TextDecoration.underline,fontWeight:FontWeight.bold,color: Colors.deepOrange)," Sign up"),
                  ),
                ],

              ) ,
            )


          ],
        ),
      ),
    );
  }
}
