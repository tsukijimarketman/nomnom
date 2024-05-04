import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/admin/add_business.dart';
import 'package:nomnom/admin/add_food.dart';
import 'package:nomnom/admin/admin_login.dart';
import 'package:nomnom/admin/delete_food.dart';
import 'package:nomnom/pages/businessdetail.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/widget/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  int? numLength;

  @override
  void initState() {
    super.initState();
    getNumberOfBusinesses();
    onTheLoadBusiness();
  }

  Stream<int> getNumberOfBusinesses() {
  return FirebaseFirestore.instance.collection('Businesses').snapshots().map((snapshot) => snapshot.size);
}

Stream? BusinessStream;
  onTheLoadBusiness() async {
    BusinessStream = await DatabaseMethods().getFoodItem("Businesses");
    setState(() {});
  }

Widget allItems() {
    return StreamBuilder(
        stream: BusinessStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessDetail(detail: ds["Detail"], image: ds["Image"], email: ds["Email"], name: ds["Name"], password: ds["Password"],)
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, bottom: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image.network(
                                      ds["Image"],
                                      fit: BoxFit.cover,
                                      height: 70,
                                      width: MediaQuery.of(context).size.width,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13, top: 5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ds["Name"],
                                          maxLines: 1,
                                          style: AppWidget
                                              .semiboldTextFieldStyle(),
                                        ),
                                        Text(
                                          ds["Detail"],
                                          style: AppWidget.SoftTextFieldStyle(),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

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
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black,),
                    width: 160,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Number",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 27),
                          ),
                          Row(children: [
                            Text(
                              "of",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Businesses",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15),
                            ),
                          ]),
                          SizedBox(height: 20,),
                          Center(
                          child: StreamBuilder<int>(
                            stream: getNumberOfBusinesses(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: "Poppins",
                                    fontSize: 40),
                              );
                            },
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Food Businesses", style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 17)),
                                          SizedBox(height:10),
                        Container(height: 145, width: 150,
                        child: allItems(),),
                      ],
                    ),
                  )
                ],
              ),
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
                            "Add Business",
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
                            "Delete Business",
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
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminLogin()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
