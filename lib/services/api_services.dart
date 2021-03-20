import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chat_gh/models/myposts_model.dart';
import 'package:chat_gh/models/cur_user_model.dart';
import 'package:chat_gh/models/all_posts.dart';
import 'package:chat_gh/models/selected_post.dart';
import 'package:chat_gh/models/comments_model.dart';
import 'package:chat_gh/models/search_model.dart';

Future login<bool>(String email, String pw) async {
  String url = "justask2k20dev.herokuapp.com";
  try {
    http.Response response = await http.post(
        Uri.https(url, '/rest-auth/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'email': email, 'password': pw}));
    var data = response.body;

    print(jsonDecode(data)['key']);
    SharedPreferences token_login = await SharedPreferences.getInstance();
    token_login.setString('token_login', jsonDecode(data)['key']);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}

Future logout() async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    await http.get(
      Uri.https(url, '/rest-auth/logout/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    prefs.clear();

    return true;
  } catch (e) {
    print(e);
  }
}

Future register<bool>(String email, String pw1, String pw2) async {
  String url = "justask2k20dev.herokuapp.com";
  try {
    http.Response response = await http.post(
        Uri.https(url, '/rest-auth/registration/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password1': pw1,
          'password2': pw2
        }));
    var data = response.body;
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(data);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}

Future addTask(String title, String body, String tags) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.post(
        Uri.https(url, '/api/posts/newpost/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'token ' + token,
        },
        body: jsonEncode(
            <String, String>{'title': title, 'body': body, 'tags': tags}));
    var data = response.body;
    print(jsonDecode(data));

    return true;
  } catch (e) {
    print(e);
  }
}

Future<List<AllPosts>> allPosts() async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.get(
      Uri.https(url, '/api/posts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    var data = response.body;
    List<AllPosts> datalist;

    print(jsonDecode(data));

    datalist =
        (jsonDecode(data) as List).map((e) => AllPosts.fromJson(e)).toList();
    print(datalist);

    return datalist;
  } catch (e) {
    print(e);
  }
}

Future<List<MyPosts>> myPosts() async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.get(
      Uri.https(url, '/api/posts/myposts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    var data = response.body;
    List<MyPosts> datalist;

    print(jsonDecode(data));

    datalist =
        (jsonDecode(data) as List).map((e) => MyPosts.fromJson(e)).toList();
    print(datalist);

    return datalist;
  } catch (e) {
    print(e);
  }
}

Future<CurUser> curUser() async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.get(
      Uri.https(url, '/api/profiles/curuser/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    var data = response.body;
    print(data);
    return CurUser.fromJson(jsonDecode(data));
  } catch (e) {
    print(e);
  }
}

Future<SelectedPost> selectedPost(int id) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.get(
      Uri.https(url, '/api/posts/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    var data = response.body;
    print(data);
    return SelectedPost.fromJson(jsonDecode(data));
  } catch (e) {
    print(e);
  }
}

Future<List<Comment>> comments(int id) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.get(
      Uri.https(url, '/api/comments/getcomments/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    var data = response.body;
    List<Comment> comments;
    print(data);

    comments =
        (jsonDecode(data) as List).map((e) => Comment.fromJson(e)).toList();

    return comments;
  } catch (e) {
    print(e);
  }
}

Future addComment({int id, String comment}) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response =
        await http.post(Uri.https(url, '/api/comments/newcomment/$id/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'token ' + token,
            },
            body: jsonEncode(<String, String>{'body': comment}));
    var data = response.body;
    print(jsonDecode(data));

    return true;
  } catch (e) {
    print(e);
  }
}

Future deletePost(int id) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.delete(
      Uri.https(url, '/api/posts/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + token,
      },
    );
    print(response.body);
  } catch (e) {
    print(e);
  }
}

Future<List<Search>> searchquery(String query) async {
  String url = 'justask2k20dev.herokuapp.com';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token_login');
  print('token: ' + token);
  try {
    http.Response response = await http.post(
        Uri.https(url, '/api/posts/search/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'query': query}));

    var data = response.body;
    List<Search> queries;
    print(data);

    queries =
        (jsonDecode(data) as List).map((e) => Search.fromJson(e)).toList();

    return queries;
  } catch (e) {
    print(e);
  }
}
