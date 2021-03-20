import 'dart:convert';

List<AllPosts> allPostsFromJson(String str) =>
    List<AllPosts>.from(json.decode(str).map((x) => AllPosts.fromJson(x)));

String allPostsToJson(List<AllPosts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPosts {
  AllPosts({
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
  String thumbnail;
  DateTime timestamp;
  String getUsername;
  String getUserpic;
  int author;
  int likecount;
  int commentcount;

  factory AllPosts.fromJson(Map<String, dynamic> json) => AllPosts(
        id: json["id"],
        title: json["title"],
        tags: json["tags"],
        body: json["body"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
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
        "thumbnail": thumbnail == null ? null : thumbnail,
        "timestamp": timestamp.toIso8601String(),
        "get_username": getUsername,
        "get_userpic": getUserpic,
        "author": author,
        "likecount": likecount,
        "commentcount": commentcount,
      };
}
