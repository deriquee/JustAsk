import 'package:flutter/material.dart';
import 'package:chat_gh/models/cur_user_model.dart';
import 'package:chat_gh/services/api_services.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: curUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return buildInfo(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Widget buildInfo(AsyncSnapshot<CurUser> snapshot) {
  return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.blue.shade100,
            child: SizedBox(
              width: 300,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 108,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://justask2k20dev.herokuapp.com${snapshot.data.getProimage}"), //NetworkImage
                        radius: 100,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${snapshot.data.getProname}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email: ${snapshot.data.getProemail}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Date joined: ${snapshot.data.getDatejoined.day}-${snapshot.data.getDatejoined.month}-${snapshot.data.getDatejoined.year}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Questions asked: ${snapshot.data.getTotalquestions}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
