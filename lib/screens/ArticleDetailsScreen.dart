import 'package:flutter/material.dart';
import '../Providers/news_article_prov.dart';
import 'package:provider/provider.dart';
import '../utils/convertColor.dart';

class ArticleDetailsScreen extends StatelessWidget {
  static const routeName = "/articleDetails";

  @override
  Widget build(BuildContext context) {
    final articleId = ModalRoute.of(context).settings.arguments as String;
    print(articleId);
    final blog = Provider.of<Blogs>(context).fetchBlog(articleId);
    blog.body.replaceAll("Share via: Facebook Twitter LinkedIn", "");
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "AfriTechArchiver",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: colorConvert("#8A0707"),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.network(
                  blog.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    blog.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  blog.body,
                  style: TextStyle(fontSize: 21),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Archive This Article",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: colorConvert("#8A0707"),
              )
            ],
          ),
        ));
  }
}
