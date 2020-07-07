class SearchUserModel {
  int code;
  String msg;
  List<Data> data;

  SearchUserModel({this.code, this.msg, this.data});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String chatNo;
  String username;
  String avatar;
  String briefDesc;

  Data({this.id, this.chatNo, this.username, this.avatar, this.briefDesc});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatNo = json['chat_no'];
    username = json['username'];
    avatar = json['avatar'];
    briefDesc = json['brief_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_no'] = this.chatNo;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['brief_desc'] = this.briefDesc;
    return data;
  }
}
