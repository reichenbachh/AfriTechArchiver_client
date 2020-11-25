import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/convertColor.dart';
import '../Providers/news_article_prov.dart';
import '../widgets/NewsArticleItem.dart';

class FetchedArticlesScreen extends StatefulWidget {
  const FetchedArticlesScreen({
    Key key,
  }) : super(key: key);

  @override
  _FetchedArticlesScreenState createState() => _FetchedArticlesScreenState();
}

class _FetchedArticlesScreenState extends State<FetchedArticlesScreen> {
  @override
  Widget build(BuildContext context) {
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
          future: Provider.of<Blogs>(context, listen: false).fetchBlogs(),
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
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return NewsArticleItem(
                            blogImageUrl: blogData.blogList[i].imageUrl,
                            blogTitle: blogData.blogList[i].title,
                            blogId: blogData.blogList[i].id,
                            body: blogData.blogList[i].body,
                            homeContext: context,
                          );
                        },
                        itemCount: blogData.blogList.length,
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
