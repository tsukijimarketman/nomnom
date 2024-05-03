import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nomnom/pages/profile.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';
import 'package:random_string/random_string.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String? value;
  String? id;
  TextEditingController cityController = new TextEditingController();
  TextEditingController barangayController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();

  updateAddress() async {
    if (cityController.text != "" &&
        barangayController.text != "" &&
        detailController != "") {
      Map<String, dynamic> addItem = {
        "City": cityController.text,
        "Barangay": barangayController.text,
        "Detail": detailController.text,
      };
      await DatabaseMethods().addAddress(addItem, id!);
    }
  }

  getSharedPreferences() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onTheLoad() async {
    await getSharedPreferences();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onTheLoad();
  }

   Future<void> deleteAddressCollection(String userId) async {
  CollectionReference userAddress = FirebaseFirestore.instance.collection('users');
  DocumentReference userDoc = userAddress.doc(userId);
  CollectionReference addressCollection = userDoc.collection('Address');

  // Get all documents in the "Address" collection
  QuerySnapshot snapshot = await addressCollection.get();

  // Delete each document in the "Address" collection
  for (DocumentSnapshot doc in snapshot.docs) {
    await doc.reference.delete();
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  )),
              Center(
                child: Text(
                  "Edit Address",
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "City",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your city",
                      hintStyle: AppWidget.SoftTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Barangay",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: barangayController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your barangay",
                      hintStyle: AppWidget.SoftTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Other Detail",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: detailController,
                  maxLines: 6,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          "Enter the additional detail like street number, house number, etc",
                      hintStyle: AppWidget.SoftTextFieldStyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    await deleteAddressCollection(id!);
                    updateAddress();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text(
                          "Address has been updated succesfully",
                          style: TextStyle(fontSize: 18),
                        )));
                    Navigator.pop(context);
                    
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent),
                    child: Center(
                        child: Text("Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 20))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
