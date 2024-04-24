import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_project/models/post.dart';

class HttpGetPost {
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    try {
      http.Response response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        var postMaps = jsonDecode(response.body); // json to map conversion
        postMaps.forEach((element) {
          Post postObject = Post.fromJson(element); // map to object conversion
          posts.add(postObject);
        });
      }
    } catch (e) {
      throw (e.toString());
    }
    return posts;
  }
}
