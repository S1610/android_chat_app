import 'package:android_chat_app/pages/chat_page.dart';
import 'package:android_chat_app/pages/dataset_collector.dart';
import 'package:android_chat_app/pages/robot_price_calculator.dart';
import 'package:android_chat_app/services/auth_gate.dart';
import 'package:android_chat_app/services/auth_servic.dart';
import 'package:android_chat_app/widgets/app_drawer.dart'; // Ensure this file contains the AppDrawer widget
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 2;

  final List<Widget> _pages = [RobotPriceCalculatorPage(), AuthGate(), DatasetCollector()];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_pages.length);
  }

  final List<String> _titles = [
    'Robot Price Calculator',
    'Group Chat',
    'Dataset Collector',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
        ),
        drawer: AppDrawer(
          selectedIndex: _selectedIndex,
          onItemSelected: _onDrawerItemSelected,
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
