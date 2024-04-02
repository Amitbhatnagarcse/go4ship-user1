import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/login_register/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StoreLocationMap.dart';
import 'constant/AppColor.dart';
import 'dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override State<StatefulWidget> createState() => FadeIn();}

class FadeIn extends State<SplashScreen> {
  late SharedPreferences preferences;
 late Timer _timer;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;

  FadeIn() {
    _timer = new Timer(const Duration(seconds: 3), () {
      setState(() async {
        _logoStyle = FlutterLogoStyle.horizontal;

        preferences = await SharedPreferences.getInstance();
        if(preferences.getString('userid') == null){
          Navigator.of(context).push(_createRoute());
        }else{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  //builder: (context) => DashboardScreen()));
                  builder: (context) => DashboardScreen()));
        }
      }); }); }

  @override Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        backgroundColor: ColorConstants.AppColorDark,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              //_fade(),
             // _rotate(),
              SizedBox(height: 20,),
              Image.asset(height: 200,width: 200,'assets/images/go4ship_logo.png')


              /* AnimatedAlign(
                  child: Image.asset(height: 200,width: 200,'assets/images/applogo.png'),
                  alignment: Alignment.center,
                  duration: Duration(seconds: 2)
              )*/

              //Text(style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),'Go4Ship'),
             // Image.asset(height: 200,width: 200,'assets/images/applogo.png')

            ] , ), ), ), ); }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
 Widget _fade(){
   return SizedBox(
     child: DefaultTextStyle(
       style: const TextStyle(
         fontSize: 32.0,
         fontWeight: FontWeight.bold,
       ),
       child: Center(
         child: AnimatedTextKit(
           repeatForever: true,
           animatedTexts: [

             FadeAnimatedText('Go4Ship',
                 duration: Duration(seconds: 4),fadeOutBegin: 0.9,fadeInEnd: 0.7),
           ],
         ),
       ),
     ),
   );

 }

 Widget _rotate(){
   return Row(
     mainAxisSize: MainAxisSize.min,
     children: <Widget>[
       const SizedBox(width: 10.0, height: 100.0),

       const SizedBox(width: 15.0, height: 100.0),
       DefaultTextStyle(
         style: const TextStyle(
           fontSize: 35.0,
         ),
         child: AnimatedTextKit(
             repeatForever: true,
             isRepeatingAnimation: true,
             animatedTexts: [
               RotateAnimatedText(textStyle: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.black),'Go4Ship'),

             ]),
       ),
     ],
   );
 }


 Route _createRoute() {
   return PageRouteBuilder(

     pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
     transitionsBuilder: (context, animation, secondaryAnimation, child) {
       const begin = Offset(0.0, 1.0);
       const end = Offset.zero;
       const curve = Curves.ease;

       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

       return SlideTransition(
         position: animation.drive(tween),
         child: child,
       );
     },
   );
 }
}

/*new FlutterLogo(
              size: 200.0, style: _logoStyle, )*/