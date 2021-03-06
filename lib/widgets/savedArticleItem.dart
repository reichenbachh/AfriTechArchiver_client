import 'package:afri_tech_news_archives/Providers/news_article_prov.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/ArticleDetailsScreen.dart';
import '../model.dart';
import '../utils/convertColor.dart';
import '../utils/AuthService.dart';
import 'package:firebase_core/firebase_core.dart';

class SavedArticleItem extends StatelessWidget {
  final String blogImageUrl;
  final String blogTitle;
  final String blogId;
  final String body;
  final BuildContext homeContext;
  SavedArticleItem(
      {this.blogTitle,
      this.blogImageUrl,
      this.body,
      @required this.blogId,
      this.homeContext});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ArticleDetailsScreen.routeName, arguments: blogId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                child: Image.network(
                  blogImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: Text(
                      blogTitle,
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: colorConvert("#8A0707"),
                      iconSize: 30,
                      onPressed: () async {
                        print(user);
                        final snackBar = SnackBar(
                          content:
                              Text("You need to Login to archive articles"),
                        );

                        if (user != null) {}
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
