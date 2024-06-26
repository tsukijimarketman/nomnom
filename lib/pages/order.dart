import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? foodStream;
  String? id, wallet;
  int total = 0, amount2 = 0, totalAmount = 0;

//access the baranggay, city, detail
  Future<void> printAddressDetails(String userId) async {
  // Reference to the user's address collection
  CollectionReference addressCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('Address');

  // Get data from the user's address collection
  QuerySnapshot addressSnapshot = await addressCollection.get();

  // Iterate through the documents in the address collection
  for (QueryDocumentSnapshot addressDoc in addressSnapshot.docs) {
    // Get the Baranggay, City, and Detail fields from the document data
    String barangay = addressDoc.get('Barangay');
    String city = addressDoc.get('City');
    String detail = addressDoc.get('Detail');

    // Print the address details
    print('Barangay: $barangay, City: $city, Detail: $detail');
  }
}

  Future<void> copyDataFromCollectionToAnother(String id) async {
    // Reference to the source collection
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(id);
    CollectionReference userAddressCollection = userDoc.collection("Address");

    // Reference to the destination collection
    CollectionReference destinationCollection =
        FirebaseFirestore.instance.collection('orders');

    // Get data from the users collection
    DocumentSnapshot userSnapshot = await userDoc.get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // Get data from the user's address collection
    QuerySnapshot addressSnapshot = await userAddressCollection.get();
    List<Map<String, dynamic>> addresses = addressSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Combine the data into a single document
    Map<String, dynamic> mergedData = {
      ...userData,
      'addresses': addresses,
    };

    // Add the merged data to the destination collection as a single document
    await destinationCollection.add(mergedData);
  }

  Future<void> deleteCartCollection(String userId) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(userId);
    CollectionReference cartCollection = userDoc.collection('Cart');

    // Get all documents in the "Cart" collection
    QuerySnapshot snapshot = await cartCollection.get();

    // Delete each document in the "Cart" collection
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        amount2 = total;
      });
    });
  }

  getTheSharedPreferences() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  onTheLoad() async {
    await getTheSharedPreferences();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    onTheLoad();
  }

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["Total"]);
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  ds["Quantity"],
                                  style: TextStyle(fontFamily: "Poppins"),
                                )),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiboldTextFieldStyle(),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "₱${ds["Total"]}",
                                    style: AppWidget.semiboldTextFieldStyle(),
                                  ),
                                ],
                              )
                            ],
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
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                        child: Text(
                      "Food Cart",
                      style: AppWidget.HeadlineTextFieldStyle(),
                    )))),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.51,
              child: foodCart(),
            ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "₱${total.toString()}",
                    style: AppWidget.semiboldTextFieldStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm to checkout food"),
                        content: Text("Are you sure you want to checkout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              int amount = int.parse(wallet!) - amount2;
                              await DatabaseMethods()
                                  .updateUserWallet(id!, amount.toString());
                              await SharedPreferenceHelper()
                                  .saveUserWallet(amount.toString());
                              Navigator.of(context).pop();
                              await copyDataFromCollectionToAnother(id!);
                              totalAmount = amount2;
                              Map<String, dynamic> updatedUserInfo = {
                                'Total Price':
                                    totalAmount, // Add the new field here
                                // Add other updated fields as needed
                              };
                              await DatabaseMethods()
                                  .updateUserDetail(updatedUserInfo, id!);
                              //await printAddressDetails(id!);
                              await deleteCartCollection(id!);
                              setState(() {
                                total = 0;
                              });
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                    child: Text(
                  "Checkout",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: "Poppins"),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
