import 'dart:convert';

import 'package:chat/http/dio.dart';
import 'package:chat/models/infoModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  
  Data _user;
  
  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }
  
  _fetchInfo()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.get('token');
    dio.get('/user/info',options: Options(
      headers: {
        'Authorization':'Bearer ' + _token
      }
    ))
    .then((res){
      InfoModel _model = InfoModel.fromJson(json.decode(res.toString()));
      setState(() {
        _user = _model.data;
      });
    })
    .catchError((e){
      print(e);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1335);
    return SafeArea(
      child: _user != null ?
      ListView(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setWidth(40),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setWidth(200),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setWidth(180),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: Image.network(_user.avatar, fit: BoxFit.cover,),
                ),
                Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_user.username, style: TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.w500
                      ),),
                      Expanded(child: Container()),
                      Text('轻聊号：' + _user.chatNo, style: TextStyle(
                          fontSize: ScreenUtil().setSp(26),
                          color: Colors.grey
                      ),),
                      SizedBox(height: ScreenUtil().setWidth(10),)
                    ],
                  ),
                ),
                Expanded(child: Container(),),
                Icon(Icons.keyboard_arrow_right,
                  size: ScreenUtil().setWidth(80),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(60),
          ),
          Container(
            height: ScreenUtil().setWidth(20),
            color: Colors.grey.withOpacity(0.1),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.perm_camera_mic,color: Colors.greenAccent,),
                      SizedBox(width: ScreenUtil().setWidth(10),),
                      Text('我的动态'),
                      Expanded(child: Container()),
                      Icon(Icons.keyboard_arrow_right,color: Colors.grey.withOpacity(0.8),),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.perm_camera_mic,color: Colors.greenAccent,),
                      SizedBox(width: ScreenUtil().setWidth(10),),
                      Text('我的动态'),
                      Expanded(child: Container()),
                      Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.perm_camera_mic,color: Colors.greenAccent,),
                      SizedBox(width: ScreenUtil().setWidth(10),),
                      Text('我的动态'),
                      Expanded(child: Container()),
                      Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setWidth(20),
            color: Colors.grey.withOpacity(0.1),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            child: Row(
              children: <Widget>[
                Icon(Icons.settings,color: Colors.greenAccent,),
                SizedBox(width: ScreenUtil().setWidth(10),),
                Text('设置'),
                Expanded(child: Container()),
                Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(100),
          ),
        ],
      ) :
      Center(
        child: RefreshProgressIndicator(),
      )
    );
  }
}
