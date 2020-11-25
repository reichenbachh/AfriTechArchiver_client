import 'package:afri_tech_news_archives/utils/convertColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/ArticleDetailsScreen.dart';
import 'package:provider/provider.dart';
import '../model.dart';
import '../Providers/news_article_prov.dart';

class NewsArticleItem extends StatelessWidget {
  final String blogImageUrl;
  final String blogTitle;
  final String blogId;
  final String body;
  final BuildContext homeContext;
  NewsArticleItem(
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
                      icon: Icon(Icons.archive),
                      color: colorConvert("#8A0707"),
                      iconSize: 30,
                      onPressed: () async {
                        if (user != null) {
                          try {
                            await Provider.of<Blogs>(context, listen: false)
                                .archiveBlog(
                                    user.uid,
                                    Blog(
                                      body: body,
                                      title: blogTitle,
                                      imageUrl: blogImageUrl,
                                      id: blogId,
                                    ));
                            final successSnackBar = SnackBar(
                              content: Text("Article has been archived"),
                              action: SnackBarAction(
                                  label: "Undo", onPressed: () {}),
                            );
                            Scaffold.of(context).showSnackBar(successSnackBar);
                          } catch (e) {
                            await showDialog<Null>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content: Text(e),
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
                        } else if (user == null) {
                          final snackBar = SnackBar(
                            content:
                                Text("You need to Login to archive articles"),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
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
