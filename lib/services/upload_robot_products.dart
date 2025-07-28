import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RobotProductsUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadRobotProducts() async {
    try {
      // Load the JSON file from assets
      String jsonString = await rootBundle.loadString('lib/assets/robot_products.json');
      List<dynamic> robotProducts = json.decode(jsonString);

      // Reference to the Firestore collection
      CollectionReference collectionRef = _firestore.collection('robotProducts');

      // Upload each product to Firestore
      for (var product in robotProducts) {
        String title = product['title'];
        await collectionRef.doc(title.replaceAll(' ', '_').toLowerCase()).set(product);
        print('Uploaded product: $title');
      }

      print('All robot products uploaded successfully!');
    } catch (e) {
      print('Error uploading robot products: $e');
    }
  }
}