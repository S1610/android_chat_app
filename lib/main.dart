import 'package:android_chat_app/firebase_options.dart';
import 'package:android_chat_app/pages/dataset_collector.dart';
import 'package:android_chat_app/pages/home_page.dart';
import 'package:android_chat_app/pages/robot_price_calculator.dart';
import 'package:android_chat_app/services/auth_gate.dart';
import 'package:android_chat_app/services/upload_robot_products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }
   // Upload robot products to Firestore
  // RobotProductsUploader uploader = RobotProductsUploader();
  // await uploader.uploadRobotProducts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home:HomePage(),
    );
  }
}
