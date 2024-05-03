import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/pages/details.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool burger = false,
      pasta = false,
      pizza = false,
      chicken = false,
      salad = false,
      drinks = false;
      String? name;

      getTheSharedPreferences() async {
    name = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  onThisLoad() async {
    await getTheSharedPreferences();
    setState(() {});
  }

  Stream? foodItemStream;
  onTheLoad() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Burger");
    setState(() {});
  }

  @override
  void initState() {
    onTheLoad();
    onThisLoad();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: foodItemStream,
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
                              builder: (context) => Details(detail: ds["Detail"], image: ds["Image"], price: ds["Price"], name: ds["Name"],)
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, bottom: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            height: 300,
                            width: 230,
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
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13, bottom: 13, top: 5),
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
                                        Text(
                                          '₱${ds["Price"]}',
                                          style: AppWidget.PHP(),
                                        )
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

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(detail: ds["Detail"], image: ds["Image"], price: ds["Price"], name: ds["Name"],),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    child: Image.network(
                                      ds["Image"],
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          ds["Name"],
                                          style:
                                              AppWidget.semiboldTextFieldStyle(),
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          ds["Detail"],
                                          style: AppWidget.SoftTextFieldStyle(),
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          "₱${ds["Price"]}",
                                          style: AppWidget.PHP(),
                                        ))
                                  ],
                                )
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello ${name}, ",
                            style: AppWidget.boldTextFieldStyle()),
                        Container(
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.storage,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Delight in every Bite",
                        style: AppWidget.HeadlineTextFieldStyle()),
                    Text("Your Doorstep Dining Experience",
                        style: AppWidget.SoftTextFieldStyle()),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(child: showItem()),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(height: 280, child: allItems()),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Food Items",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 5),
                child: allItemsVertically(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async{
              if (burger == false) {
                burger = true;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                foodItemStream = await DatabaseMethods().getFoodItem("Burger");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 5.0,
              color: burger ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Burger",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () async{
              if (pasta == false) {
                burger = false;
                pasta = true;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                foodItemStream = await DatabaseMethods().getFoodItem("Pasta");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 5.0,
              color: pasta ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Pasta",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () async{
              if (pizza == false) {
                burger = false;
                pasta = false;
                pizza = true;
                chicken = false;
                salad = false;
                drinks = false;
                foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 5.0,
              color: pizza ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Pizza",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () async{
              if (chicken == false) {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = true;
                salad = false;
                drinks = false;
                foodItemStream = await DatabaseMethods().getFoodItem("Chicken");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 5.0,
              color: chicken ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Chicken",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () async{
              if (salad == false) {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = true;
                drinks = false;
                foodItemStream = await DatabaseMethods().getFoodItem("Salad");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 5.0,
              color: salad ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Salad",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () async{
              if (drinks == false) {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = true;
                foodItemStream = await DatabaseMethods().getFoodItem("Drinks");
                setState(() {});
              } else {
                burger = false;
                pasta = false;
                pizza = false;
                chicken = false;
                salad = false;
                drinks = false;
                setState(() {});
              }
            },
            child: Material(
              elevation: 10.0,
              color: drinks ? Colors.grey : Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 105,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Drinks",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
