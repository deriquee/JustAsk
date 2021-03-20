import 'package:chat_gh/views/chat_signin.dart';
import 'package:flutter/material.dart';
import 'package:chat_gh/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'home.dart';
import 'sign_in.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.blue.shade100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: MediaQuery.of(context).size.width / 1.3,
                    width: MediaQuery.of(context).size.width / 1.3,
                  ),
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: username,
                    decoration: InputDecoration(
                        hintText: 'username@example.com',
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Email',
                        hintStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Use a alphanumeric 6 char password ',
                        hintStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      bool isTrue = await register(
                          username.text, password.text, password.text);
                      if (isTrue == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      } else {
                        error = "User already exists or check your credentials";
                        password.text = "";
                        setState(() {});
                      }
                    },
                    child: Text('Register'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
