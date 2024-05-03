import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomnom/widget/widget_support.dart';

class DeleteFood extends StatefulWidget {
  const DeleteFood({Key? key}) : super(key: key);

  @override
  State<DeleteFood> createState() => _DeleteFoodState();
}

class _DeleteFoodState extends State<DeleteFood> {
  final List<String> items = [
    'Burger',
    'Pasta',
    'Pizza',
    'Chicken',
    'Salad',
    'Drinks'
  ];
  String? value;
  List<String> documents = [];
  String? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Delete Food Item",
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: MediaQuery.of(context).size.height/3.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(height: 40,),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Poppins'
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                      if (value != null) {
                        _getDocuments(value!);
                      } else {
                        documents = [];
                        selectedDocument = null;
                      }
                    });
                  },
                  dropdownColor: Colors.white,
                  hint: Text(
                    "Select Category",
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                  iconSize: 36,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
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
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDocument = value;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: Text(
                      "Select Food Item",
                      style: AppWidget.semiboldTextFieldStyle(),
                    ),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: selectedDocument,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedDocument != null) {
                    _showDeleteConfirmationDialog(value!, selectedDocument!);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please select a document to delete."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Delete Selected Document"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get documents from Firestore
  Future<void> _getDocuments(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(name).get();
    setState(() {
      documents = querySnapshot.docs.map((doc) => doc.id).toList();
    });
  }

  // Function to show delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog(String collectionName, String documentId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Food Item"),
          content: Text("Are you sure you want to delete this food item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteDocument(collectionName, documentId);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // Function to delete document from Firestore
  Future<void> _deleteDocument(String collectionName, String documentId) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).doc(documentId).delete();
      setState(() {
        documents.remove(documentId);
        selectedDocument = null;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Document deleted successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to delete document: $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
