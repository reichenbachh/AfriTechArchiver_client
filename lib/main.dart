import 'package:afri_tech_news_archives/utils/convertColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//screens
import './screens/AuthScreen.dart';
import './screens/Home.dart';
import './screens/ArticleDetailsScreen.dart';
import './utils/whiteColor.dart';
import './Providers/news_article_prov.dart';
import 'package:provider/provider.dart';
import './utils/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Blogs(),
        ),
        Provider<AuthService>(
          create: (ctx) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (ctx) => ctx.read<AuthService>().authStateChanged,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: colorConvert("#8A0707"),
          primarySwatch: white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            headline4: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        routes: {
          "/": (ctx) => HomeScreen(),
          ArticleDetailsScreen.routeName: (ctx) => ArticleDetailsScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen()
        },
      ),
    );
  }
}
