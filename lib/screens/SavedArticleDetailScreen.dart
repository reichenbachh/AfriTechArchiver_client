import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/convertColor.dart';
import '../widgets/savedArticleItem.dart';
import '../Providers/news_article_prov.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({
    Key key,
  }) : super(key: key);

  @override
  _SavedArticlesScreenState createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search,
                      color: colorConvert("#8A0707"), size: 30),
                  suffixStyle: TextStyle(fontSize: 20),
                  hintText: "Filter news",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: Provider.of<Blogs>(context, listen: false)
              .fetchSavedBlogs(user.uid),
          builder: (context, dataSnapshot) {
            print(dataSnapshot.connectionState);
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              print("loading");
              return Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              if (dataSnapshot.error != null) {
                print(dataSnapshot.error);
                return Center(
                  child: Container(
                    child: Text(
                      "An error occured,please check connection or restart app",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              } else {
                return Consumer<Blogs>(
                  builder: (ctx, blogData, i) {
                    return Expanded(
                      child: blogData.savedBlogList.length == 0
                          ? Center(child: Text("You have no archived Blogs"))
                          : ListView.builder(
                              itemBuilder: (context, i) {
                                return SavedArticleItem(
                                  blogImageUrl:
                                      blogData.savedBlogList[i].imageUrl,
                                  blogTitle: blogData.savedBlogList[i].title,
                                  blogId: blogData.savedBlogList[i].id,
                                  body: blogData.savedBlogList[i].body,
                                  homeContext: context,
                                );
                              },
                              itemCount: blogData.savedBlogList.length,
                            ),
                    );
                  },
                );
              }
            }
          },
        )
      ],
    );
  }
}
