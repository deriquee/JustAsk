import 'dart:convert';

CurUser curUserFromJson(String str) => CurUser.fromJson(json.decode(str));

String curUserToJson(CurUser data) => json.encode(data.toJson());

class CurUser {
  CurUser({
    this.id,
    this.user,
    this.image,
    this.getProname,
    this.getProemail,
    this.getProimage,
    this.getTotalquestions,
    this.getDatejoined,
  });

  int id;
  int user;
  String image;
  String getProname;
  String getProemail;
  String getProimage;
  int getTotalquestions;
  DateTime getDatejoined;

  factory CurUser.fromJson(Map<String, dynamic> json) => CurUser(
        id: json["id"],
        user: json["user"],
        image: json["image"],
        getProname: json["get_proname"],
        getProemail: json["get_proemail"],
        getProimage: json["get_proimage"],
        getTotalquestions: json["get_totalquestions"],
        getDatejoined: DateTime.parse(json["get_datejoined"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "image": image,
        "get_proname": getProname,
        "get_proemail": getProemail,
        "get_proimage": getProimage,
        "get_totalquestions": getTotalquestions,
        "get_datejoined": getDatejoined.toIso8601String(),
      };
}
