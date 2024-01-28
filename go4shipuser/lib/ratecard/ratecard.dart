import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';
import '../dashboard/Model/CabListModel.dart';
import 'model/ratecardmodel.dart';

//List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class RateCard extends StatefulWidget {
  const RateCard({super.key});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  //String dropdownValue = list.first;
  late SharedPreferences preferences;
  late String cabid = "3";

  ScrollController? _controller;
  List packagelist = [];
  List<CustomCategoryCodeList> custom_category_code_list = [];
  List response_district_list= [];
  @override
  void initState() {
    getCategory();
getDataPackage(cabid);
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
          title: Text('Rate Card'),
          backgroundColor: ColorConstants.AppColorDark),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                      width: 25, height: 25, 'assets/images/map_location.png'),
                  Column(
                    children: [
                      Container(
                        child: Text(
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            '  Select category'),
                      ),
                     /* Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(left: 20),
                        width: 225,
                        color: Colors.grey.shade200,
                        child: DropdownButton(
                         // value: dropdownValue,
                          items: list
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
                        ),
                      )*/

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(left: 20),
                        width: 200,
                        height: 40,
                        color: Colors.grey.shade200,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            iconSize: 15,
                            elevation: 11,
                            //style: TextStyle(color: Colors.black),
                            /// style: Theme.of(context).textTheme.bodyText1,
                            isExpanded: true,
                            // hint: new Text("Select State"),
                            items: custom_category_code_list.map((item) {
                              return DropdownMenuItem(
                                  child: Row(
                                    children: [
                                      new Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              item.cabtype.toString(),
                                              //Names that the api dropdown contains
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  value: item.id
                                      .toString() //Id that has to be passed that the dropdown has.....
                              );
                            }).toList(),
                            onChanged:(String? newVal) {
                              setState(() {
                                cabid = newVal!;
                                print('cabid:$cabid');
                                getDataPackage(cabid);
                              });
                            },
                            value: cabid.toString(), //pasing the default id that has to be viewed... //i havnt used something ... //you can place some (id)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: .5,
            ),
            Center(
              heightFactor: 1.5,
              child: Text(
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  '  REGULAR'),
            ),
            Divider(
              color: Colors.grey,
              height: .5,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorConstants.AppColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Image.asset(
                        height: 45, width: 45, 'assets/images/black_car.png')),
                Text(
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    '  Micro'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              height: .5,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  '  Total Fair'),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
              height: .5,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: _helpItemBuilder()
            ),
          ],
        ),
      ),
    );
  }

  void getDataPackage(String cabid) async {
    //print('cabid_confirm${widget.cabid}');

    try {
      FormData formData = FormData.fromMap({
        AppConstants.CABID: cabid,
      });

      var response = await Dio().post(
          AppConstants.app_base_url + AppConstants.PackageLIST_URL,
          data: formData);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          packagelist = response.data['result'] as List;
          print('print lenth${packagelist}');
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<RateCardModel> getCategory() async {
   /*await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );*/
    preferences = await SharedPreferences.getInstance();
    var response = await post(Uri.parse(AppConstants.app_base_url + AppConstants.cablist_Api), body: {

      AppConstants.UserId: preferences.getString('userid'),

    });
    var resBody = json.decode(response.body);
    final apiResponse = RateCardModel.fromJson(resBody);
    setState(() {
      if (apiResponse.result!= null) {
        response_district_list = resBody['result'][0]['cabtypes'];
        print('response_district_list${response_district_list}');
        custom_category_code_list.clear();
       // custom_category_code_list.add(CustomCategoryCodeList(unitcode: "0", unitNameHindi:Strings.choose));
        for (int i = 0; i < response_district_list.length; i++) {

          custom_category_code_list.add(CustomCategoryCodeList(id: resBody['result'][0]['cabtypes'][i]['id'],cabtype:  resBody['result'][0]['cabtypes'][i]['cabtype']));

          print('response_district_list${custom_category_code_list[i].cabtype}');
          print('response_district_list${custom_category_code_list[i].id}');


        }
       // _selectedDistrictUnitCode = custom_category_code_list[0].unitcode.toString();


      } else {
        custom_category_code_list.clear();
      }
    });
    return RateCardModel.fromJson(resBody);
  }

  int getHelpLength() {
    if (packagelist.isNotEmpty) {
      return packagelist.length;
    } else {
      return 0;
    }
  }
  Widget _helpItemBuilder() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            controller: _controller,
            itemCount: getHelpLength(),
            itemBuilder: _helpitemBuilder,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true));
  }
  Widget _helpitemBuilder(BuildContext context, int index) {
    return InkWell(
        child:GestureDetector(
          onTap: () {
            /*setState(() {

              _changePackagetext.text = packagelist[index]['hour'].toString() +
                  ' Hour ' +
                  packagelist[index]['km'].toString() +
                  ' KM ' +
                  packagelist[index]['price'].toString() +
                  ' INR';
              Navigator.of(context).pop();
            });*/

          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: ColorConstants.AppColorDark),
              ),
              // color: (index % 2 == 0) ? Colors.white :ColorConstants.AppColorDark,
            ),
            child: Column(
              children: [
                Container(
                  //  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      packagelist[index]['hour'].toString() +
                          ' Hour ' +
                          packagelist[index]['km'].toString() +
                          ' KM ' +
                          packagelist[index]['price'].toString() +
                          ' INR',
                      style: TextStyle(
                          fontSize: 13,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //  holder.additional.setText("Additional charges for extra distance : "+currency+" "+ride.getAdddist()+"/Km"+
                  //         "\nextra time : "+currency+" "+ride.getAddtime()+"/Hr");
                  child: Text(
                    'Additional charges for extra distance : INR  ${packagelist == null ? "" : packagelist[index]['charge_for_additional_dist'].toString() + '/KM' + '\nextra time : ' + ' INR ' + packagelist[index]['charge_for_additional_time'].toString()}',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),

          ) ,
        )


    );
  }
}

class CustomCategoryCodeList {
  String? cabtype;
  String? id;

  CustomCategoryCodeList({this.cabtype,this.id});
}
