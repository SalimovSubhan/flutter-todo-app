import 'package:app_test_alif/bloc/post/post_bloc.dart';
import 'package:app_test_alif/bloc/post/post_event.dart';
import 'package:app_test_alif/bloc/post/post_state.dart';
import 'package:app_test_alif/models/post.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var localPost;

class PostListPage extends StatefulWidget {
  final int userId;

  PostListPage({required this.userId});

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(LoadPostsEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          'Posts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<PostBloc>().add(LoadPostsEvent(widget.userId));
            },
          ),
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoadedState) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                localPost = post;
                return Card(
                  child: ListTile(
                    tileColor: darkOrwhite ? Colors.grey : Colors.blueGrey,
                    textColor: darkOrwhite ? Colors.white : Colors.white60,
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              UpdatePostShowDialog(context, post);
                            },
                            icon: Icon(
                              Icons.create,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () {
                              DeletePostShowDialog(context, post);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/comments',
                        arguments: post.id,
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No posts available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreatPostShowDialog(context, localPost);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> CreatPostShowDialog(BuildContext context, Post post) {
    var body = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Post",
          ),
          content: TextField(
            controller: body,
            decoration: InputDecoration(
              label: Text("body"),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close")),
            TextButton(
                onPressed: () {
                  final posts = Post(
                      body: body.text,
                      id: post.id,
                      title: post.title,
                      userId: post.userId);
                  context.read<PostBloc>().add(CreatePostEvent(posts));
                  Navigator.of(context).pop();
                },
                child: Text("Save")),
          ],
        );
      },
    );
  }

  Future<dynamic> DeletePostShowDialog(BuildContext context, Post post) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PostBloc>().add(DeletePostEvent(post.id));
                Navigator.of(context).pop();
                context.read<PostBloc>().add(LoadPostsEvent(post.userId));
              },
              child: Text('Delete'),
            ),
          ],
        ),
      );

  Future<dynamic> UpdatePostShowDialog(BuildContext context, Post post) {
    var body = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: body,
              decoration: InputDecoration(labelText: 'body'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final posts = Post(
                  body: body.text,
                  id: post.id,
                  title: post.title,
                  userId: post.userId);
              context.read<PostBloc>().add(UpdatePostEvent(posts));
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
