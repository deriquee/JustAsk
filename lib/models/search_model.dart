import 'dart:convert';

List<Search> searchFromJson(String str) =>
    List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
  Search({
    this.id,
    this.title,
    this.tags,
    this.body,
    this.thumbnail,
    this.timestamp,
    this.getUsername,
    this.getUserpic,
    this.author,
    this.likecount,
    this.commentcount,
  });

  int id;
  String title;
  String tags;
  String body;
  dynamic thumbnail;
  DateTime timestamp;
  String getUsername;
  String getUserpic;
  int author;
  int likecount;
  int commentcount;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"],
        title: json["title"],
        tags: json["tags"],
        body: json["body"],
        thumbnail: json["thumbnail"],
        timestamp: DateTime.parse(json["timestamp"]),
        getUsername: json["get_username"],
        getUserpic: json["get_userpic"],
        author: json["author"],
        likecount: json["likecount"],
        commentcount: json["commentcount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tags": tags,
        "body": body,
        "thumbnail": thumbnail,
        "timestamp": timestamp.toIso8601String(),
        "get_username": getUsername,
        "get_userpic": getUserpic,
        "author": author,
        "likecount": likecount,
        "commentcount": commentcount,
      };
}
