import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('动态页'),
      ),
    );
  }
}
