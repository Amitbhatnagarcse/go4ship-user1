import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class RateCard extends StatefulWidget {
  const RateCard({super.key});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Rate Card'),
          backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                      width: 35, height: 35, 'assets/images/map_location.png'),
                  Column(
                    children: [
                      Container(
                        child: Text(
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            '  Select category'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(left: 20),
                        width: 300,
                        color: Colors.grey.shade200,
                        child: DropdownButton(
                          value: dropdownValue,
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
                      fontSize: 20,
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
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Image.asset(
                        height: 50, width: 50, 'assets/images/black_car.png')),
                Text(
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    '  Micro'),
              ],
            ),
            SizedBox(height: 20,),
            Divider(
              color: Colors.grey,
              height: .5,
            ),

            Container(
              margin: EdgeInsets.only(top:10),
              child: Text(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  '  Total Fair'),
            ),
            SizedBox(height: 10,),
            Divider(
              color: Colors.grey,
              height: .5,
            ),
            SizedBox(height: 20,),
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
    );
  }
}
