import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:chat/http/dio.dart';
import 'package:chat/models/loginRes.dart';
import 'package:chat/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String chatNo;
  String password;
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  _login()async{
    var loginForm = loginKey.currentState;
    if (loginForm.validate()){
      loginForm.save();
      dio.post("/user/login", data: {"chat_no": chatNo, "password": password})
          .then((res) async{
        LoginRes _loginRes = LoginRes.fromJson(json.decode(res.toString()));
        if(_loginRes.code == 0){
          //success
          BotToast.showText(text: '登录成功');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _loginRes.data.token);
          Navigator.of(context).pop();
        }else{
          //fail
          BotToast.showText(text: _loginRes.msg);
        }
      })
          .catchError((e) {
        print(e);
      });
      print(chatNo + ':' + password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1334);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setWidth(200),
            ),
            Container(
              child: Center(
                child: Text('轻 聊',style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontFamily: ''
                ),),
              ),
            ),
            Container(
              width: ScreenUtil().setHeight(750),
              child: Form(
                  key: loginKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '轻聊账号'),
                        onSaved: (value) {
                          chatNo = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: '密码',
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green
                  ),
                  child: Center(
                    child: Text('登录',style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),),
                  ),
                ),
                onTap: _login,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(10),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                GestureDetector(
                  child: Text('没有账号？去注册',style: TextStyle(
                    fontSize: ScreenUtil().setSp(28)
                  ),),
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
