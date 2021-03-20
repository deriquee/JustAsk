import 'package:chat_gh/models/all_posts.dart';
import 'package:chat_gh/services/api_services.dart';
import 'package:flutter/material.dart';
import 'drawer_main.dart';
import 'add_task.dart';
import 'post_single.dart';
import 'sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Posts'),
        actions: [
          GestureDetector(
              onTap: () async {
                await logout();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              },
              child: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddTask());
        },
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: allPosts(),
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

Widget buildPosts(AsyncSnapshot<List<AllPosts>> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SinglePost(
                                id: snapshot.data[index].id,
                              )));
                },
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Posted on ${snapshot.data[index].timestamp.day}-${snapshot.data[index].timestamp.month}-${snapshot.data[index].timestamp.year}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'By ${snapshot.data[index].getUsername}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tags:  ${snapshot.data[index].tags}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        // return ListTile(
        //   title: Text(snapshot.data[index].title),
        //   trailing: Text(
        //       'Posted on ${snapshot.data[index].timestamp.day}-${snapshot.data[index].timestamp.month}-${snapshot.data[index].timestamp.year}'),
        //   subtitle: Text(snapshot.data[index].body),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => SinglePost(
        //                   id: snapshot.data[index].id,
        //                 )));
        //   },
        // );
      });
}
