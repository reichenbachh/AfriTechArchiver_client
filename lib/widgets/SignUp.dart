import 'package:afri_tech_news_archives/utils/AuthService.dart';
import 'package:afri_tech_news_archives/utils/convertColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  Future<void> _saveForm() async {
    final bool formResults = _formKey.currentState.validate();
    if (!formResults) {
      return;
    }
    _formKey.currentState.save();
    try {
      await context
          .read<AuthService>()
          .signUp(email: email, password: password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } catch (e) {
      print(e);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text("Something went wrong"),
          actions: [
            FlatButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Create An Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your email";
                    }
                    final emailRegex = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      caseSensitive: false,
                    );
                    bool emailIsValid = emailRegex.hasMatch(value);
                    if (!emailIsValid) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "pasword"),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 8 || value.length > 16) {
                      return "password length cant be less 8 characters and more than 16 characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        _saveForm();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: colorConvert("#8A0707"),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
