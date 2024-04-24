import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/models/post.dart';
import 'package:riverpod_project/services/http_get_service.dart';

final postProvider = StateNotifierProvider<PostNotifier, Poststate>(
  (ref) => PostNotifier(),
);

@immutable
abstract class Poststate {}

class PostInitialState extends Poststate {}

class PostLoadingState extends Poststate {}

class PostLoadedState extends Poststate {
  PostLoadedState({required this.posts});
  final List<Post> posts;
}

class PostErrorstate extends Poststate {
  PostErrorstate({required this.message});
  final String message;
}

class PostNotifier extends StateNotifier<Poststate> {
  PostNotifier() : super(PostInitialState());

  final HttpGetPost _getPosts = HttpGetPost();

  void fetchPosts() async {
    try {
      state = PostLoadingState();
      List<Post> posts = await _getPosts.getPosts();
      state = PostLoadedState(posts: posts);
    } catch (e) {
      state = PostErrorstate(message: e.toString());
    }
  }
}
