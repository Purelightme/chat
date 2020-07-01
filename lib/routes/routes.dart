import 'package:chat/pages/login.dart';
import 'package:chat/pages/my.dart';
import 'package:chat/pages/post.dart';
import 'package:chat/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:chat/pages/friend.dart';
import 'package:chat/pages/message.dart';

final routes = {
  '/message': (BuildContext context) => Message(),
  '/friend': (BuildContext context) => Friend(),
  '/post': (BuildContext context) => Post(),
  '/my': (BuildContext context) => My(),
  '/register': (BuildContext context) => Register(),
  '/login': (BuildContext context) => Login(),
};