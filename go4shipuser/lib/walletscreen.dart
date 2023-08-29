import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant/AppColor.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Wallet'), backgroundColor: ColorConstants.AppColorDark),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      'Referral Credits'),
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                            color: Colors.blue.shade100,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 100,
                              child: Text('Total Referral'),
                            ),
                          )),

                      Expanded(
                          child: Card(
                            color: Colors.pinkAccent.shade100,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 100,
                              child: Text('Credits Earned'),
                            ),
                          )),

                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: Card(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black),'Balance'),
                    Center(child: Text('100'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Container(
                    height: 50,
                    color: Colors.deepOrange,
                    child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),'Add Money')),
                  )),

                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Container(
                    height: 50,
                    color: CupertinoColors.activeBlue,
                    child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),'Money Transfer')),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(

              child: Card(
                child: Column(

                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: Colors.white,
                          child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),'Your Referrals')),
                        )),

                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Container(
                          height: 50,
                          color: CupertinoColors.white,
                          child: Center(child: Text(style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),'Your Transactions')),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: const Icon(Icons.list),
                                trailing: const Text(
                                  "GFG",
                                  style: TextStyle(color: Colors.green, fontSize: 15),
                                ),
                                title: Text("List item $index"));
                          }),
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
