import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AppDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Robot Price Calculator'),
            selected: selectedIndex == 0,
            onTap: () {
              Navigator.pop(context);
              onItemSelected(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Group Chat'),
            selected: selectedIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onItemSelected(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Dataset Collector'),
            selected: selectedIndex == 2,
            onTap: () {
              Navigator.pop(context);
              onItemSelected(2);
            },
          ),
        ],
      ),
    );
  }
}