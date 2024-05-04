import 'package:flutter/material.dart';
import 'package:nomnom/admin/add_business.dart';
import 'package:nomnom/admin/add_food.dart';
import 'package:nomnom/admin/delete_food.dart';
import 'package:nomnom/business/business.dart';
import 'package:nomnom/business/business_edit.dart';
import 'package:nomnom/widget/widget_support.dart';
class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({super.key});

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Business Owner Panel",
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
                    MaterialPageRoute(builder: (context) => EditFoodItems()));
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
                            "Edit Food Items",
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
            SizedBox(height: 30,),
            GestureDetector(
                    onTap: (){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BusinessLogin()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Poppins'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}