import 'package:chat_gh/models/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_gh/models/selected_post.dart';
import 'package:chat_gh/services/api_services.dart';

class SinglePost extends StatefulWidget {
  int id;
  SinglePost({this.id});
  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: FutureBuilder(
        future: selectedPost(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildPosts(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

Widget buildPosts(AsyncSnapshot<SelectedPost> snapshot) {
  TextEditingController suggestions = TextEditingController();
  return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
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
                      snapshot.data.title,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Posted on ${snapshot.data.timestamp.day}-${snapshot.data.timestamp.month}-${snapshot.data.timestamp.year}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'By ${snapshot.data.getUsername}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tags:  ${snapshot.data.tags}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      snapshot.data.body,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        //Icon(Icons.arrow_upward),
                        Text('${snapshot.data.likecount.toString()} votes'),
                        SizedBox(
                          width: 25,
                        ),
                        //Icon(Icons.arrow_downward)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.blue.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suggestions',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 100,
                      child: FutureBuilder(
                        future: comments(snapshot.data.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return buildComments(snapshot);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Suggestion',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(24)),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: suggestions,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Your suggestion',
                              labelStyle: TextStyle(
                                color: Colors.blueAccent,
                              ),
                              hintText: 'Something related... ',
                              hintStyle: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                          onPressed: () {
                            addComment(
                                id: snapshot.data.id,
                                comment: suggestions.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SinglePost(
                                          id: snapshot.data.id,
                                        )));
                          },
                          child: Text('Submit'))
                    ],
                  ))
            ],
          ),
        );
      });
}

Widget buildComments(AsyncSnapshot<List<Comment>> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              snapshot.data[index].body,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                //Icon(Icons.arrow_upward),
                Text('${snapshot.data[index].commentlike.toString()} votes'),
                //Icon(Icons.arrow_downward),
                SizedBox(
                  width: 100,
                ),
                Text('By ${snapshot.data[index].getUsername}')
              ],
            ),
          ],
        );
      });
}
