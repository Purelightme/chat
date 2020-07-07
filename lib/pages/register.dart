import 'package:chat/http/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey _registerKey = GlobalKey();

  String username,password;

  _register(){
    dio.post('/user/register',data: {
      "username":username,
      "password":password
    })
        .then((res){

    })
        .catchError((e){
          print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1335);
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
                  key: _registerKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '昵称'),
                        onSaved: (value) {
                          username = value;
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
                    child: Text('注册',style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),),
                  ),
                ),
                onTap: _register,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(10),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                GestureDetector(
                  child: Text('已有账号？去登录',style: TextStyle(
                      fontSize: ScreenUtil().setSp(28)
                  ),),
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('/login');
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
