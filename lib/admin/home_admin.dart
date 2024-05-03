import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/admin/add_business.dart';
import 'package:nomnom/admin/add_food.dart';
import 'package:nomnom/admin/delete_food.dart';
import 'package:nomnom/widget/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Admin Panel",
                style: AppWidget.HeadlineTextFieldStyle(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFood()));
              },
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/food.jpg",
                                height: 100,
                                width: MediaQuery.of(context).size.width / 4,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Add Food Items",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeleteFood()));
              },
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/food.jpg",
                                height: 100,
                                width: MediaQuery.of(context).size.width / 4,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Delete Food Items",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBusiness()));
              },
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/food.jpg",
                                height: 100,
                                width: MediaQuery.of(context).size.width / 4,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Add Business Entity",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
