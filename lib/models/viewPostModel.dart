class ViewPostModel {
  int code;
  String msg;
  Data data;

  ViewPostModel({this.code, this.msg, this.data});

  ViewPostModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int total;
  List<Post> data;

  Data({this.total, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<Post>();
      json['data'].forEach((v) {
        data.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int id;
  int userId;
  String content;
  String username;
  String avatar;
  String createdAt;

  Post(
      {this.id,
        this.userId,
        this.content,
        this.username,
        this.avatar,
        this.createdAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    username = json['username'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    return data;
  }
}
