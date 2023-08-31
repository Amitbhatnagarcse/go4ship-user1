import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/AppColor.dart';
import '../constant/AppUrl.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  List faqs_list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Support'), backgroundColor: ColorConstants.AppColorDark),

      body: SingleChildScrollView(
        child:  Container(
          child: Column(
            children: [
              Text('How can we help ?'),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Image.asset(
                            width: 10, height: 10, 'assets/images/search.png'),
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        hintText: 'Search'),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 3, right: 3, top: 5),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: getLength(),
                    // list item builder
                    itemBuilder: _itemBuilder,
                  )),

            ],
          ),
        ),
      )

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async {
    try {
      var response =
      await Dio().get(AppConstants.app_base_url + AppConstants.supportlist_Api);
      if (response.statusCode == 200) {
        setState(() {
          //print('print lenth${response.data['result'][0]['cabtypes']}');
          faqs_list = response.data['result'] as List;
          print('print lenth${faqs_list}');
          // var recordsList = response.data["cabtype"];
          // print('print cabtype......................${response.data['cabtypes']}');
        });
      }
      // print(response);
    } catch (e) {
      print(e);
    }
  }
  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        height: 250,
        child: Column(
          children: [
            Text(
                '${faqs_list[index]['ques']}',
            style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),

            SizedBox(height: 10,),
            Text(
             // 'nqjkabfkbajebfjhsbdjh',
              '${faqs_list == null ? "" : faqs_list[index]['ans']}',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),

            ),
            SizedBox(height: 10,),
            Divider(
              color: Colors.black,
              height: 2,
            )


          ],
        ),

      ),
    );
  }

  int getLength() {
    if (faqs_list.isNotEmpty) {
      return faqs_list.length;
    } else {
      return 0;
    }
  }
}
