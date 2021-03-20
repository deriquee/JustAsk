import 'package:flutter/material.dart';
import 'search_screen.dart';

class SearchBM extends StatefulWidget {
  @override
  _SearchBMState createState() => _SearchBMState();
}

class _SearchBMState extends State<SearchBM> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: search,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      hintText: 'Title of the post',
                      hintStyle: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(search.text)));
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.blueAccent),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
