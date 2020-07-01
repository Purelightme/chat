import 'package:flutter/material.dart';

class Friend extends StatefulWidget {
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('联系人页'),
      ),
    );
  }
}
