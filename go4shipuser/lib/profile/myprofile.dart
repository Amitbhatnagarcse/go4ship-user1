
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/profile/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isSelected = false;
  bool isonswitch = true;
  late SharedPreferences preferences;
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _firstNameontroller = TextEditingController();
  TextEditingController _lastNamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _countrycontroller = TextEditingController();
  TextEditingController _statecontroller = TextEditingController();
  TextEditingController _citycontroller = TextEditingController();
  TextEditingController _zipcodecontroller = TextEditingController();
  TextEditingController _refercodecontroller = TextEditingController();
  List profilelist = [];
  @override
  void initState() {
    getProfileData();
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
          title: Text('Profile'),
          actions: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile()));
            }),
          ],
          backgroundColor: ColorConstants.AppColorDark),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _phonecontroller,
                  enabled: false,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          width: 20, height: 20, 'assets/images/phone.png'),
                      border: OutlineInputBorder(),
                     ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _firstNameontroller ,
                  enabled: false,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          width: 10, height: 10, 'assets/images/user.png'),
                      border: OutlineInputBorder(),

                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailcontroller,
                  enabled: false,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          width: 20, height: 20, 'assets/images/mail.png'),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email'),
                ),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _addresscontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),

                      ),
                    ),
                    TextField(
                      controller: _countrycontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),),
                    ),
                    TextField(
                      controller: _statecontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),

                          ),
                    ),
                    TextField(
                      controller: _citycontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                      ),
                    ),
                    TextField(
                      controller: _zipcodecontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                      ),
                    ),
                    TextField(
                      controller: _refercodecontroller,
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/whatsapp.png'),
                          labelText: 'ReferCode',
                          hintText: 'Enter your Refercode'),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: false,
                child:   Container(

              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                              width: 25,
                              height: 25,
                              'assets/images/emergency.png'),
                          Text(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              '    Emergency Contect'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Enable others to track you:'),
                        Switch(
                          // This bool value toggles the switch.
                          value: isonswitch,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              isonswitch = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/user.png'),
                              labelText: 'Relative1',
                              hintText: 'Enter your Relative name'),
                        ),),
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/phone.png'),
                              labelText: 'Mobile no.',
                              hintText: 'Enter Relative Mobile no.'),
                        ),),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/user.png'),
                              labelText: 'Relative2',
                              hintText: 'Enter your Relative name'),
                        ),),
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/phone.png'),
                              labelText: 'Mobile no.',
                              hintText: 'Enter Relative Mobile no.'),
                        ),),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/user.png'),
                              labelText: 'Relative3',
                              hintText: 'Enter your Relative name'),
                        ),),
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/phone.png'),
                              labelText: 'Mobile no.',
                              hintText: 'Enter Relative Mobile no.'),
                        ),),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/user.png'),
                              labelText: 'Relative4',
                              hintText: 'Enter your Relative name'),
                        ),),
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                  width: 20,
                                  height: 20,
                                  'assets/images/phone.png'),
                              labelText: 'Mobile no.',
                              hintText: 'Enter Relative Mobile no.'),
                        ),),

                      ],
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void getProfileData() async {
    //print('emial${_phonecontroller.text.toString()}');

    preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({

        AppConstants.UserId: preferences.getString('userid'),
  
      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.ViewProfile_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          //cablist = response.data['result'][0]['cabtypes'] as List;

          var resut= response.data['result'];
          print('print response${resut}');
          if(resut != null){

           // profilelist = response.data['result'][0]['Result'] as List;
            //print('print response${response.data['result'][0]['phone']}');
            _phonecontroller.text = response.data['result'][0]['phone'];
            _emailcontroller.text = response.data['result'][0]['email'];
            _firstNameontroller.text = response.data['result'][0]['fname'] +' '+ ' '+response.data['result'][0]['lname'] ;
            _addresscontroller.text = response.data['result'][0]['address'];
            _countrycontroller.text = response.data['result'][0]['country'];
            _statecontroller.text = response.data['result'][0]['state'];
            _citycontroller.text = response.data['result'][0]['city'];
            _zipcodecontroller.text = response.data['result'][0]['zip'];
            _refercodecontroller.text = response.data['result'][0]['uid'];
           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          }else{
            print('Please Enter Valid Details');
          }


          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
