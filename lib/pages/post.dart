import 'dart:convert';

import 'package:chat/http/dio.dart';
import 'package:chat/models/viewPostModel.dart' as model;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  List<model.Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  _fetchPosts()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _token = sharedPreferences.get('token');
    dio.get('/post_view/index',options: Options(
      headers: {
        'Authorization':'Bearer ' + _token
      }
    ))
        .then((res){
          model.ViewPostModel _model = model.ViewPostModel.fromJson(json.decode(res.toString()));
          setState(() {
            _posts.addAll(_model.data.data);
          });
    })
        .catchError((e){
          print(e.response.toString());
    });
  }
  
  Widget _buildItem(model.Post post){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.avatar),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(12),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.username,style: TextStyle(
                          fontSize: ScreenUtil().setSp(42)
                      ),),
                      Text(post.createdAt,style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: Colors.grey
                      ),)
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Text(post.content),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Row(
                children: <Widget>[
                  Text('浏览70次'),
                  Expanded(child: Container()),
                  IconButton(
                      icon: Icon(Icons.build), 
                      onPressed: null,
                    iconSize: ScreenUtil().setWidth(20),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))
              ),
              child: Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    decoration: InputDecoration(
                        hintText: '评论',
                        border: InputBorder.none
                    ),
                    maxLines: 1,
                    maxLength: 200,
                  ),),
                  Container(
                    width: ScreenUtil().setWidth(80),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(18))
                    ),
                    child: Center(
                      child: Text('发送',textAlign: TextAlign.justify ),
                    )
                  ),
                ],
              )
            ),
            SizedBox(
              height: ScreenUtil().setWidth(12),
            ),
            Container(
              height: ScreenUtil().setWidth(24),
              width: ScreenUtil().setWidth(750),
              color: Colors.grey.withOpacity(0.1),
            )
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750,height: 1335);
    return Container(
      height: ScreenUtil().setWidth(1200),
      child: ListView(
        children: _posts.map((post) => _buildItem(post)).toList(),
      ),
    );
  }
}
