import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future<void> updateUserDetail(
      Map<String, dynamic> userInfoMap, String id) async {
    // Reference to the user document
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(id);

    // Update the user details in Firestore
    await userDoc.update(userInfoMap);
  }

  Future<void> updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({"Wallet": amount});
  }

  Future addFoodIem(Map<String, dynamic> userInfoMap, String name, String documentId) async {
    return await FirebaseFirestore.instance.collection(name).doc(documentId).set(userInfoMap);
  }

  Future addAddress(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Address")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future<Stream<QuerySnapshot>> getBusiness(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodtoCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .snapshots();
  }

  Future<List<DocumentSnapshot>> getAddresses(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("Address")
        .get();

    // Convert the list of DocumentSnapshot to a list of documents
    List<DocumentSnapshot> documents = querySnapshot.docs;

    return documents;
  }

  Future<Stream<QuerySnapshot>> getOrders() async {
    return await FirebaseFirestore.instance.collection("orders").snapshots();
  }

  Future addBusiness(Map<String, dynamic> userInfoMap, String documentId) async {
    return await FirebaseFirestore.instance.collection("Businesses").doc(documentId).set(userInfoMap);
  }
}
