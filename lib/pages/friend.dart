import 'dart:convert';

import 'package:chat/http/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/friendRes.dart' as FriendRes;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Friend extends StatefulWidget {
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {

  List<FriendRes.Friend> _friends = [];

  ScrollController _controller = new ScrollController();

  initState(){
    super.initState();
    _fetchFriends();
  }
  
  _fetchFriends()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String _token = _pref.getString("token");
    dio.get("/user_friend/index",options: Options(
      headers: {
        "Authorization": "Bearer " + _token
      }
    ))
        .then((res){
          FriendRes.FriendRes _friendRes = FriendRes.FriendRes.fromJson(json.decode(res.toString()));
          setState(() {
            _friends.addAll(_friendRes.data.data);
          });
    })
        .catchError((e){
          print(e.toString());
    });
  }
  
  _buildItem(FriendRes.Friend friend){
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(100),
      decoration: BoxDecoration(
        color: Colors.grey
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(friend.avatar),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(friend.username),
              Expanded(child: Container(),),
              Text(friend.briefDesc),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1350);
    return SafeArea(
      child: Container(
          width: ScreenUtil().setWidth(750),
          child: Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('新盆友'),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/findUser');
                },
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('处理好友邀请'),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/userFriendHandle');
                },
              ),
              Expanded(
                child: ListView.builder(
                    controller: _controller,
                    itemCount: _friends.length,
                    itemBuilder: (context,index) => _buildItem(_friends[index])
                ),
              ),
            ],
          )
      ),
    );
  }
}
