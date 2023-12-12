import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go4shipuser/profile/editProfile.dart';

import '../constant/AppColor.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isSelected = false;
  bool isonswitch = true;

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
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          width: 20, height: 20, 'assets/images/phone.png'),
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
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          width: 10, height: 10, 'assets/images/user.png'),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name'),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
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
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                          labelText: 'Address',
                          hintText: 'Enter your address'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                          labelText: 'Country',
                          hintText: 'Enter your Country'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                          labelText: 'State',
                          hintText: 'Enter your State'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                          labelText: 'City',
                          hintText: 'Enter your City'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/address.png'),
                          labelText: 'Zipcode',
                          hintText: 'Enter your address'),
                    ),
                    TextField(
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
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
