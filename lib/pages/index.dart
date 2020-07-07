import 'package:bot_toast/bot_toast.dart';
import 'package:chat/pages/friend.dart';
import 'package:chat/pages/message.dart';
import 'package:chat/pages/my.dart';
import 'package:chat/pages/post.dart';
import 'package:chat/routes/routes.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {

  Index({this.index = 0});

  int index;

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    Message(),
    Friend(),
    Post(),
    My(),
  ];

  initState(){
    super.initState();
    this._currentIndex = widget.index;
  }

  _changeIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      routes: routes,
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _changeIndex,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('消息')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account),
                title: Text('联系人')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bubble_chart),
                title: Text('动态')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('我的')
            ),
          ],
        ),
      ),
    );
  }
}
