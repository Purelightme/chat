class InfoModel {
  int code;
  String msg;
  Data data;

  InfoModel({this.code, this.msg, this.data});

  InfoModel.fromJson(Map<String, dynamic> json) {
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
