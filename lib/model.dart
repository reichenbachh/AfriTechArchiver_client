import 'package:flutter/foundation.dart';

class Blog {
  final String title;
  final String id;
  final String body;
  final String imageUrl;
  Blog(
      {@required this.id,
      @required this.title,
      @required this.body,
      this.imageUrl});
}
