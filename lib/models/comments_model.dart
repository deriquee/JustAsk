import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    this.id,
    this.body,
    this.author,
    this.posts,
    this.timestamp,
    this.thumbnail,
    this.getUsername,
    this.getUserpic,
    this.commentlike,
  });

  int id;
  String body;
  int author;
  int posts;
  DateTime timestamp;
  dynamic thumbnail;
  String getUsername;
  String getUserpic;
  int commentlike;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        author: json["author"],
        posts: json["posts"],
        timestamp: DateTime.parse(json["timestamp"]),
        thumbnail: json["thumbnail"],
        getUsername: json["get_username"],
        getUserpic: json["get_userpic"],
        commentlike: json["commentlike"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "author": author,
        "posts": posts,
        "timestamp": timestamp.toIso8601String(),
        "thumbnail": thumbnail,
        "get_username": getUsername,
        "get_userpic": getUserpic,
        "commentlike": commentlike,
      };
}
