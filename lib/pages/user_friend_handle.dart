import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:chat/http/dio.dart';
import 'package:chat/models/commonModel.dart';
import 'package:chat/models/userFriendHandleModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFriendHandle extends StatefulWidget {
  @override
  _UserFriendHandleState createState() => _UserFriendHandleState();
}

class _UserFriendHandleState extends State<UserFriendHandle> {
  
  List<Item> _items = [];
  
  initState(){
    super.initState();
    _fetchItems();
  }
  
  _fetchItems()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.get('token');
    dio.get('/user_friend_apply/index',options: Options(
      headers: {
        'Authorization':'Bearer ' + _token
      }
    ))
        .then((res){
          UserFriendHandleModel _model = UserFriendHandleModel.fromJson(json.decode(res.toString()));
          print(_model.data.data.toString());
          setState(() {
            _items.addAll(_model.data.data);
          });
    })
        .catchError((e){
          print(e);
    });
  }

  _handle(int id,int action)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.get('token');
    dio.post('/user_friend_apply/handle',data:{"id":id,"status":action},options: Options(
      headers: {
        'Authorization':'Bearer ' + _token
      }
    ))
        .then((res){
          CommonModel _model = CommonModel.fromJson(json.decode(res.toString()));
          if(_model.code == 0){
            BotToast.showText(text: '处理成功');
          }else{
            BotToast.showText(text: _model.msg);
          }
    })
        .catchError((e){
          print(e.response.toString());
    });
  }

  Widget _buildItem(Item item){
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(item.avatar),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.username),
                Text(item.briefDesc)
              ],
            ),
            width: ScreenUtil().setWidth(500),
          ),
          item.status == 1 ?
          Expanded(child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent
                  ),
                  child: Center(
                    child: Text('拒绝'),
                  ),
                ),
                onTap: (){
                  _handle(item.id, 2);
                },
              ),
              SizedBox(width: ScreenUtil().setWidth(8),),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.greenAccent
                  ),
                  child: Center(
                    child: Text('同意'),
                  ),
                ),
                onTap: (){
                  _handle(item.id, 3);
                },
              ),
            ],
          )) :
          Expanded(
                child: Row(
                  children: <Widget>[
                    item.status == 2 ?
                    Text('已拒绝') :
                    Text('已同意')
                  ],
                ),
              )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1334);
    return Scaffold(
      appBar: AppBar(
        title: Text('好友申请列表'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: Column(
          children: <Widget>[
            Expanded(child: ListView(
              children: _items.map((item) => _buildItem(item)).toList()
            ))
          ],
        )
      ),
    );
  }
}
