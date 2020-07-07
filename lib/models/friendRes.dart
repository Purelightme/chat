class FriendRes {
  int code;
  String msg;
  Data data;

  FriendRes({this.code, this.msg, this.data});

  FriendRes.fromJson(Map<String, dynamic> json) {
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
  List<Friend> data;

  Data({this.total, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<Friend>();
      json['data'].forEach((v) {
        data.add(new Friend.fromJson(v));
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

class Friend {
  int friendId;
  String chatNo;
  String username;
  String avatar;
  String briefDesc;
  String createdAt;

  Friend(
      {this.friendId,
        this.chatNo,
        this.username,
        this.avatar,
        this.briefDesc,
        this.createdAt});

  Friend.fromJson(Map<String, dynamic> json) {
    friendId = json['friend_id'];
    chatNo = json['chat_no'];
    username = json['username'];
    avatar = json['avatar'];
    briefDesc = json['brief_desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friend_id'] = this.friendId;
    data['chat_no'] = this.chatNo;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['brief_desc'] = this.briefDesc;
    data['created_at'] = this.createdAt;
    return data;
  }
}
