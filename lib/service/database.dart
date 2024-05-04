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

  Future<DocumentSnapshot<Map<String, dynamic>>> getFoodItem2(String name, String id) async {
    return await FirebaseFirestore.instance.collection(name).doc(id).get();
  }

  Future<Stream<QuerySnapshot>> getAllFoodItem(name) async {
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

  Future<void> updateFoodItem(Map<String, dynamic> updatedItem, String documentId, String name) async {
    try {
      // Update the document in Firestore
      await FirebaseFirestore.instance
          .collection(name) // Replace 'your_collection_name' with your actual collection name
          .doc(documentId)
          .update(updatedItem);
    } catch (e) {
      print("Error updating document: $e");
      throw e;
    }
  }

  Future<Stream> getFoodItemForBusiness(String businessName, String itemName) async {
    return FirebaseFirestore.instance
        .collection(itemName)
        .where("Business", isEqualTo: businessName)
        .snapshots();
  }

  Future<String?> getUserNameById(String userId) async {
    try {
      // Get the document snapshot corresponding to the provided userId
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Cast the data to Map<String, dynamic> to access its fields
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        // Extract and return the 'Name' field value
        return userData?['Name'];
      } else {
        // If the document does not exist, return null
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print("Error getting user name: $e");
      return null;
    }
  }
}
