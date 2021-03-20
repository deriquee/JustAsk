import 'package:flutter/material.dart';
import 'package:chat_gh/services/api_services.dart';
import 'home.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskname = TextEditingController();
  TextEditingController taskdata = TextEditingController();
  TextEditingController tasktags = TextEditingController();
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
                  controller: taskname,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: 'a title for your curiosity',
                      hintStyle: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: taskdata,
                  decoration: InputDecoration(
                      labelText: 'what are you curious about...',
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      hintText: 'question...... ',
                      hintStyle: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: tasktags,
                  decoration: InputDecoration(
                      labelText: 'Tags',
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      hintText: 'python,django,etc..',
                      hintStyle: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () async {
                    await addTask(taskname.text, taskdata.text, tasktags.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blueAccent),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
