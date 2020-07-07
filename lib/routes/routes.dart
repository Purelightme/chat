import 'package:chat/pages/findUser.dart';
import 'package:chat/pages/index.dart';
import 'package:chat/pages/login.dart';
import 'package:chat/pages/my.dart';
import 'package:chat/pages/post.dart';
import 'package:chat/pages/register.dart';
import 'package:chat/pages/user_friend_handle.dart';
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
  '/index': (BuildContext context) => Index(),
  '/findUser': (BuildContext context) => FindUser(),
  '/userFriendHandle': (BuildContext context) => UserFriendHandle(),
};