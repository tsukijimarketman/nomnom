import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/business/business_edit_details.dart';
import 'package:nomnom/pages/details.dart';
import 'package:nomnom/service/database.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';

class EditFoodItems extends StatefulWidget {
  const EditFoodItems({super.key});

  @override
  State<EditFoodItems> createState() => _EditFoodItemsState();
}

class _EditFoodItemsState extends State<EditFoodItems> {
  final List<String> items = [
    'Burger',
    'Pasta',
    'Pizza',
    'Chicken',
    'Salad',
    'Drinks'
  ];
  String? value;

  bool burger = false,
      pasta = false,
      pizza = false,
      chicken = false,
      salad = false,
      drinks = false;
  String? name;

  List<String> documents = [];
  String? selectedDocument;

  getTheSharedPreferences() async {
    name = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  onThisLoad() async {
    await getTheSharedPreferences();
    setState(() {});
  }

  DocumentSnapshot<Map<String, dynamic>>? foodItemSnapshot;
  onTheLoad() async {
    if (value != null && selectedDocument != null) {
      foodItemSnapshot = await DatabaseMethods().getFoodItem2(value!, selectedDocument!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    onThisLoad();
  }

  Widget allItemsVertically() {
    return foodItemSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1, // Since we have only one document
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var ds = foodItemSnapshot!;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDetails(selectedDocument: selectedDocument, valued: value,)
                    ),
                  );
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
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Image.network(
                              ds["Image"],
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Name"],
                                  style: AppWidget.semiboldTextFieldStyle(),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Detail"],
                                  style: AppWidget.SoftTextFieldStyle(),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "₱${ds["Price"]}",
                                  style: AppWidget.PHP(),
                                ),
                              ),
                            
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : CircularProgressIndicator();
  }

  Future<void> _getDocuments(String name) async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(name).get();
  setState(() {
    documents = querySnapshot.docs.map((doc) => doc.id).toSet().toList(); // Use Set to ensure uniqueness
    print(documents); // Add this line to check for duplicate values
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Food Item",
          style: AppWidget.HeadlineTextFieldStyle(),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                            if (value != null) {
                              _getDocuments(value!);
                              onTheLoad();
                            } else {
                              documents = [];
                              selectedDocument = null;
                            }
                          });
                        },
                        dropdownColor: Colors.black,
                        hint: Text(
                          "Select Category",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                        iconSize: 36,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        value: value,
                      ),
                    ),
                    if (value != null && documents.isNotEmpty)
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: documents
                              .map((doc) => DropdownMenuItem<String>(
                                    value: doc,
                                    child: Text(
                                      doc,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDocument = value;
                              onTheLoad(); // Reload the data when document changes
                            });
                          },
                          dropdownColor: Colors.black,
                          hint: Text(
                            "Select Food Item",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          value: selectedDocument,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(height: 130, child: allItemsVertically()),
            )
          ],
        ),
      ),
    );
  }
}
