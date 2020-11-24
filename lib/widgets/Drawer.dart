import 'package:afri_tech_news_archives/utils/convertColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/AuthScreen.dart';
import '../screens/Home.dart';
import 'package:provider/provider.dart';
import '../utils/AuthService.dart';
import '../screens/AuthScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Sign In Options",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: colorConvert("#8A0707")),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login or Sign Up"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AuthScreen()));
            },
          ),
          Divider(
            color: Colors.black,
          ),
          user != null
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () async {
                    await context.read<AuthService>().signOut();
                    await showDialog<Null>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("User Login"),
                        content: Text("You have been logged out"),
                        actions: [
                          FlatButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).push(MaterialPageRoute(
                                  builder: (ctx) => AuthScreen()));
                            },
                          )
                        ],
                      ),
                    );
                  },
                )
              : SizedBox()
        ],
      ),
    );
  }
}
