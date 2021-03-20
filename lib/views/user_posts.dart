import 'package:chat_gh/services/api_services.dart';
import 'package:chat_gh/views/drawer_main.dart';
import 'package:flutter/material.dart';
import 'package:chat_gh/blocs/myposts_bloc.dart';
import 'package:chat_gh/models/myposts_model.dart';
import 'package:chat_gh/views/post_single.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPosts extends StatefulWidget {
  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    // bloc.fetchMyPosts();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),

      // body: StreamBuilder(
      //   stream: bloc.myPosts,
      //   builder: (context, AsyncSnapshot<MyPosts> snapshot) {
      //     if (snapshot.hasData) {
      //       return buildPosts(snapshot);
      //     } else if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   },
      // ),
      body: FutureBuilder(
        future: myPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return buildPosts(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget buildPosts(AsyncSnapshot<List<MyPosts>> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(snapshot.data[index].title),
          subtitle: Text(
              'Posted on ${snapshot.data[index].timestamp.day}-${snapshot.data[index].timestamp.month}-${snapshot.data[index].timestamp.year}'),
          trailing: GestureDetector(
              onTap: () async {
                await deletePost(snapshot.data[index].id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPosts()));
              },
              child: Icon(FontAwesomeIcons.trash)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SinglePost(
                          id: snapshot.data[index].id,
                        )));
          },
        );
      });
}
