import 'home.dart';
import 'package:flutter/material.dart';
import 'package:chat_gh/services/api_services.dart';
import 'register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email_tec = TextEditingController();
  TextEditingController password_tec = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    controller: email_tec,
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
                    controller: password_tec,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Use atleast six char',
                        hintStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      bool isTrue =
                          await login(email_tec.text, password_tec.text);
                      if (isTrue == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } else {
                        error = 'Check your credentials';
                        password_tec.text = "";

                        setState(() {});
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text('Register with email'),
                  ),
                ),
                // SizedBox(height: 15.0),
                // Container(
                //   width: MediaQuery.of(context).size.width / 1.4,
                //   height: 45.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(16)),
                //     color: Colors.redAccent,
                //   ),
                //   child: MaterialButton(
                //     onPressed: () {},
                //     child: Text(
                //       'Login with Google',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
