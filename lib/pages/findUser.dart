import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:chat/http/dio.dart';
import 'package:chat/models/commonModel.dart';
import 'package:chat/models/searchUserModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindUser extends StatefulWidget {
  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  String chatNo;
  List<Data> _datas = [];

  _search(){
    setState(() {
      _datas = [];
    });
    dio.get('/user_search/index',queryParameters:{"chat_no":chatNo})
        .then((res){
          SearchUserModel _model = SearchUserModel.fromJson(json.decode(res.toString()));
          setState(() {
            _datas.addAll(_model.data);
          });
    })
    .catchError((e){
      print(e);
    });
  }

  _apply(String chatNo)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.get('token');
      dio.post('/user_friend_apply/store', data: {"chat_no": chatNo},options: Options(
        headers: {
          "Authorization": 'Bearer ' + _token
        }
      ))
          .then((res) {
        CommonModel _model = CommonModel.fromJson(json.decode(res.toString()));
        if (_model.code == 0) {
          BotToast.showText(text: '成功发送好友邀请');
        } else {
          BotToast.showText(text: _model.msg);
        }
      })
          .catchError((e) {
        print(e.response.data.toString());
      });
    }

  Widget _buildUser(Data data){
    return Container(
      width: ScreenUtil().setWidth(700),
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(data.avatar),
                ),
                SizedBox(width: ScreenUtil().setWidth(18),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.username),
                    Text(data.briefDesc,style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.blueGrey
                    ),),
                  ],
                ),
              ],
            ),),
          SizedBox(
            height: ScreenUtil().setWidth(8),
          ),
          InkWell(
              child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                  height: ScreenUtil().setWidth(60),
                  width: ScreenUtil().setWidth(700),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1)
                  ),
                  child: Center(
                    child: Text('添加好友'),
                  )
              ),
              onTap: (){
                _apply(data.chatNo);
              }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索好友'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: '轻聊账号'
                ), focusNode: _focusNode, controller: _controller,
                onChanged: (value){
                  chatNo = value;
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(20),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                width: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))
                ),
                child: Center(
                  child: Text('查找',style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
              onTap: _search,
            ),
            SizedBox(
              height: ScreenUtil().setWidth(100),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                  child: Text(_datas.length > 0 ? '一共为您找到'+_datas.length.toString()+'位轻聊用户:' : '',style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.grey.withOpacity(0.7)
                  ),),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: _datas.map((data) => _buildUser(data)).toList()
              ),
            ),
          ],
        )
      ),
    );
  }
}
