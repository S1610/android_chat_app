import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;

  const UserTile({
    super.key,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          //icon
          Icon(Icons.person),
          //user name
          Text(text),
        ],
        ),
    );
  }
}