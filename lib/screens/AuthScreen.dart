import 'package:flutter/material.dart';
import '../widgets/SignIn.dart';
import '../widgets/SignUp.dart';
import '../widgets/Drawer.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Sign In"),
                ),
                Tab(
                  child: Text("Sign Up"),
                ),
              ],
            ),
            title: Text('Login or Sign Up'),
          ),
          drawer: AppDrawer(),
          body: TabBarView(
            children: [
              SignIn(),
              SignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
