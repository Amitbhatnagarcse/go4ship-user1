import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';
import '../constant/DialogUtils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _firstNameontroller = TextEditingController();
  TextEditingController _lastNamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _countrycontroller = TextEditingController();
  TextEditingController _statecontroller = TextEditingController();
  TextEditingController _citycontroller = TextEditingController();
  TextEditingController _zipcodecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: pop,
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                backgroundColor: ColorConstants.AppColorDark),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Mobile')),
                        Expanded(
                          child: TextField(
                            controller: _phonecontroller,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    width: 20,
                                    height: 20,
                                    'assets/images/phone.png'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConstants.AppColorDark,
                                      width: 2),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: 'Enter valid 10 digit mobile no.'),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('First Name')),

                        Expanded(
                          child: TextField(
                            controller: _firstNameontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    width: 20,
                                    height: 20,
                                    'assets/images/phone.png'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConstants.AppColorDark,
                                      width: 2),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: 'Enter First Name'),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(

                        children: [
                          Expanded(child: Text('Last Name')),
                          Expanded(
                            child: TextField(
                              controller: _lastNamecontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),

                                  hintText: 'Enter Last Name'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Email')),
                          Expanded(
                            child: TextField(
                              controller: _emailcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter valid Email'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Address')),
                          Expanded(
                            child: TextField(
                              controller: _addresscontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter valid Address'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Country')),
                          Expanded(
                            child: TextField(
                              controller: _countrycontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter Country Name'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('State')),
                          Expanded(
                            child: TextField(
                              controller: _statecontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),

                                  hintText: 'Enter State Name'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('City')),
                          Expanded(
                            child: TextField(
                              controller: _citycontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      width: 20,
                                      height: 20,
                                      'assets/images/phone.png'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter City Name'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Zipcode')),
                          Expanded(
                            child: TextField(
                              controller: _zipcodecontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstants.AppColorDark,
                                        width: 2),
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter Zipcode'),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {


                        ValidData();

                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorConstants.AppColorDark,
                        ),
                        child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white,fontSize: 18),
                            'Update')),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<bool> pop() async {
    return true;
  }

  void getUpdateProfile() async {
    print('emial${_phonecontroller.text.toString()}');
   // print('password${_passwordcontroller.text.toString()}');
    //print('FCM_TOKEN${fcmtoken}');
   // preferences = await SharedPreferences.getInstance();
    try {
      FormData formData = FormData.fromMap({

        AppConstants.UPHONENO: _phonecontroller.text.toString(),
        AppConstants.UFNAME: _firstNameontroller.text.toString(),
        AppConstants.ULNAME: _lastNamecontroller.text.toString(),
        AppConstants.UMAIL: _emailcontroller.text.toString(),
        AppConstants.UADDR: _addresscontroller.text.toString(),
        AppConstants.COUNTRY: _countrycontroller.text.toString(),
        AppConstants.STATE: _statecontroller.text.toString(),
        AppConstants.CITY: _citycontroller.text.toString(),
        AppConstants.ZIP: _zipcodecontroller.text.toString(),

      });
      //response = await dio.post("/info", data: formData);
      // print(“Response FormData :: ${formData}”);

      var response =
      await Dio().post(AppConstants.app_base_url + AppConstants.EditProfilw_URL,data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          //cablist = response.data['result'][0]['cabtypes'] as List;

          var resut= response.data['result'][0]['Result'];
          print('print response${resut}');
         /* if(resut=='Login success'){
            preferences.setString("userid", response.data['result'][0]['userid']);
            preferences.setString("uid", response.data['result'][0]['uid']);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          }else{
            print('Please Enter Valid Details');
          }*/


          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      print(response);
    } catch (e) {
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
    }else if(_firstNameontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter first name ');
      // MyToast.getToast('Please enter password ');
    }else if(_lastNamecontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter last name ');
      // MyToast.getToast('Please enter password ');
    }else if(_emailcontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter Email ');
      // MyToast.getToast('Please enter password ');
    }else if(_addresscontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter Address ');
      // MyToast.getToast('Please enter password ');
    }else if(_countrycontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter Country ');
      // MyToast.getToast('Please enter password ');
    }else if(_statecontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter State ');
      // MyToast.getToast('Please enter password ');
    }else if(_citycontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter City ');
      // MyToast.getToast('Please enter password ');
    }else if(_zipcodecontroller.text.toString().isEmpty){
      DialogUtils.showCustomDialog(context, message: 'Please enter ZipCode ');
      // MyToast.getToast('Please enter password ');
    }else{
      getUpdateProfile();
    }
  }
}
