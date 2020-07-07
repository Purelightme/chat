class UserFriendHandleModel {
  int code;
  String msg;
  Data data;

  UserFriendHandleModel({this.code, this.msg, this.data});

  UserFriendHandleModel.fromJson(Map<String, dynamic> json) {
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
  List<Item> data;

  Data({this.total, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<Item>();
      json['data'].forEach((v) {
        data.add(new Item.fromJson(v));
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

class Item {
  int id;
  String chatNo;
  String username;
  String avatar;
  String briefDesc;
  String remark;
  int status;

  Item(
      {this.id,
        this.chatNo,
        this.username,
        this.avatar,
        this.briefDesc,
        this.remark,
        this.status});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatNo = json['chat_no'];
    username = json['username'];
    avatar = json['avatar'];
    briefDesc = json['brief_desc'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_no'] = this.chatNo;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['brief_desc'] = this.briefDesc;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}
