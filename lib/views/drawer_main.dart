import 'package:chat_gh/models/cur_user_model.dart';
import 'package:flutter/material.dart';
import 'chat_signin.dart';
import 'user_posts.dart';
import 'package:chat_gh/services/api_services.dart';
import 'package:chat_gh/views/search_screen.dart';
import 'package:chat_gh/views/search.dart';
import 'package:chat_gh/views/user_profile.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: FutureBuilder(
              future: curUser(),
              builder: (context, AsyncSnapshot<CurUser> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Image.network(
                              'https://justask2k20dev.herokuapp.com${snapshot.data.getProimage}',
                              width: 100,
                              height: 75,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.getProname,
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
            ),
          ),
          ListTile(
            title: Text('Chat'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
          ListTile(
            title: Text('Search'),
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (context) => SearchBM());
            },
          ),
          ListTile(
            title: Text('My Posts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserPosts()));
            },
          ),
          ListTile(
            title: Text('Profile Info'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserInfo()));
            },
          ),
        ],
      ),
    );
  }
}
