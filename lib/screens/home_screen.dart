import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/states/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Consumer(builder: (context, ref, child) {
        Poststate state = ref.watch(postProvider);
        if (state is PostInitialState) {
          return const Text("Press FAB to fetch data");
        }

        if (state is PostLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is PostErrorstate) {
          return Text(state.message);
        }
        if (state is PostLoadedState) {
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(state.posts[index].id.toString()),
                  ),
                  title: Text(state.posts[index].title ?? ""),
                );
              });
        }
        return const Text('Nothing found');
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
