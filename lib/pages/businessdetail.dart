import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomnom/pages/details.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/widget/widget_support.dart';

class BusinessDetail extends StatefulWidget {
  String image, name, detail, email, password;
  BusinessDetail(
      {required this.image,
      required this.name,
      required this.detail,
      required this.email,
      required this.password});

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {

  Stream? foodItemStream;
  String products="Burger";
  onTheLoad(String itemName) async {
  foodItemStream = await DatabaseMethods().getFoodItemForBusiness(widget.name, itemName);
  setState(() {});
}

  bool burger = false,
      pasta = false,
      pizza = false,
      chicken = false,
      salad = false,
      drinks = false;

      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onTheLoad(products);
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food Company",
          style: AppWidget.HeadlineTextFieldStyle(),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF373866),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(100), child: Image.network(widget.image, height: 200,))),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(child: showItem(),),
              ),
              SizedBox(height: 20,),
              Text(
                      "Food Items ${widget.name}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Container(
                height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                child: allItemsVertically(),
              ),),
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
                setState(() {
                  onTheLoad("Burger");
                });
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
                setState(() {
                  onTheLoad("Pasta");
                });
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
                setState(() {
                  onTheLoad("Pizza");
                });
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
                setState(() {
                  onTheLoad("Chicken");
                });
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
                setState(() {
                  onTheLoad("Salad");
                });
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
                setState(() {
                  onTheLoad("Drinks");
                });
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
