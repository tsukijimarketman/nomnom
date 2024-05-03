import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';

class RiderDashboard extends StatefulWidget {
  const RiderDashboard({super.key});

  @override
  State<RiderDashboard> createState() => _RiderDashboardState();
}

class _RiderDashboardState extends State<RiderDashboard> {
  String? name;

  getTheSharedPreferences() async {
    name = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  onThisLoad() async {
    await getTheSharedPreferences();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onThisLoad();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Text("Incoming deliveries",
                    style: AppWidget.HeadlineTextFieldStyle()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFD61C38)),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$name",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 21),
                        ),
                        Text(
                          "Php 100",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Click to see details",
                          style: TextStyle(color: Colors.yellow, fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
