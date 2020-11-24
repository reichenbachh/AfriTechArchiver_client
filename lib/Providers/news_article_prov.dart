import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appException.dart';
import '../model.dart';

class Blogs with ChangeNotifier {
  List<Blog> _blogList = [];

  List<Blog> get blogList {
    return [..._blogList];
  }

  Future<void> fetchBlogs() async {
    try {
      print("yes");

      CollectionReference blogs =
          FirebaseFirestore.instance.collection("scraped_tech_news");

      final response = await blogs.get();
      response.docs.forEach((article) {
        print(response.docs.length);
        _blogList.add(Blog(
          id: article["id"],
          title: article["title"],
          body: article["body"],
          imageUrl: article["imageUrl"],
        ));
      });
      notifyListeners();
    } catch (e) {
      print("error" + e);
      throw e;
    }
  }

  Blog fetchBlog(String id) {
    return _blogList.firstWhere((element) => element.id == id);
  }
}
