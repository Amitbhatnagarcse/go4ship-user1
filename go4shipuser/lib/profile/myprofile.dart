import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.orange),
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
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)

              ),
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
              child: Row(
                children: [
                  Image.asset(width: 20,height: 20,'assets/images/emergency.png')
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)

              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Enable others to track you:'
                    ),
                    /*ToggleButtons(
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      },
                      children: const <Widget>[
                        Icon(Icons.ac_unit),
                        Icon(Icons.call),
                        Icon(Icons.cake),
                      ],
                    ),*/



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
          ],
        ),
      ),
    );
  }
}
