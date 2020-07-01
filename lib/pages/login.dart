import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String chatNo;
  String password;
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  _login() {
    var loginForm = loginKey.currentState;
    if (loginForm.validate()){
      loginForm.save();
      print(chatNo + ':' + password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1334);
    return Scaffold(
      body:ListView(
        children: <Widget>[
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
            width: ScreenUtil().setHeight(700),
            height: ScreenUtil().setHeight(50),
            child: RaisedButton(
              onPressed: _login,
              child: Text('登录',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
