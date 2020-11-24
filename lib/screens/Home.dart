import 'package:flutter/material.dart';
import '../utils/convertColor.dart';
import '../widgets/NewsArticleItem.dart';
import 'package:provider/provider.dart';
import '../Providers/news_article_prov.dart';
import '../widgets/Drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: Column(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorConvert("#8A0707"),
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "archive",
          )
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
