import 'package:chat_gh/models/search_model.dart';
import 'package:flutter/material.dart';
import 'drawer_main.dart';
import 'package:chat_gh/services/api_services.dart';
import 'post_single.dart';

class SearchPage extends StatefulWidget {
  String query;
  SearchPage(this.query);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future: searchquery(widget.query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildResults(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

Widget buildResults(AsyncSnapshot<List<Search>> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SinglePost(
                          id: snapshot.data[index].id,
                        )));
          },
          child: ListTile(
            title: Text(snapshot.data[index].title),
            subtitle: Text(snapshot.data[index].body),
            trailing: Text(
                'Posted on ${snapshot.data[index].timestamp.day}-${snapshot.data[index].timestamp.month}-${snapshot.data[index].timestamp.year}'),
          ),
        );
      });
}
