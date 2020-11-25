import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appException.dart';
import '../model.dart';

class Blogs with ChangeNotifier {
  List<Blog> _blogList = [];

  List<Blog> _savedBlogList = [];

  List<Blog> get savedBlogList {
    return [..._savedBlogList];
  }

  List<Blog> get blogList {
    return [..._blogList];
  }

  Future<void> fetchBlogs() async {
    try {
      print("yes");

      CollectionReference blogs =
          FirebaseFirestore.instance.collection("scraped_tech_news");

      _blogList = [];
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

  Future<void> fetchSavedBlogs(String id) async {
    try {
      print("id :" + id);
      CollectionReference blogs =
          FirebaseFirestore.instance.collection("saved_blogs");

      final docExists = await blogs.doc(id).collection("blog_list").get();
      print(docExists.docs.length);
      if (docExists.docs.length == 0) {
        return;
      }
      _savedBlogList = [];
      final savedBlogData = await blogs.doc(id).collection("blog_list").get();
      savedBlogData.docs.forEach((blog) {
        _savedBlogList.add(Blog(
            id: blog["id"],
            title: blog["title"],
            body: blog["body"],
            imageUrl: blog["imageUrl"]));
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> archiveBlog(String id, Blog blogItem) async {
    try {
      CollectionReference blogs =
          FirebaseFirestore.instance.collection("saved_blogs");

      final blogExists =
          await blogs.doc(id).collection("blog_list").doc(blogItem.id).get();
      if (blogExists.exists) {
        if (blogExists.data()["id"] == blogItem.id) {
          throw "This article has already been archived";
        }
      }

      final Map<String, dynamic> blogObj = {
        "id": blogItem.id,
        "title": blogItem.title,
        "body": blogItem.body,
        "imageUrl": blogItem.imageUrl
      };
      await blogs
          .doc(id)
          .collection("blog_list")
          .doc(blogObj["id"])
          .set(blogObj);

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Blog fetchBlog(String id) {
    return _blogList.firstWhere((element) => element.id == id);
  }
}
