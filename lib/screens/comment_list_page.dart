import 'package:app_test_alif/bloc/comment/comment_bloc.dart';
import 'package:app_test_alif/bloc/comment/comment_event.dart';
import 'package:app_test_alif/bloc/comment/comment_state.dart';
import 'package:app_test_alif/models/comment.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var com;

class CommentListPage extends StatefulWidget {
  final int postId;

  CommentListPage({required this.postId});

  @override
  _CommentListPageState createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(LoadCommentsEvent(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<CommentBloc>().add(LoadCommentsEvent(widget.postId));
            },
          ),
        ],
      ),
      body: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentLoadedState) {
            final comments = state.comments;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                com = comment;
                return Card(
                  child: ListTile(
                    tileColor: darkOrwhite ? Colors.grey : Colors.blueGrey,
                    textColor: darkOrwhite ? Colors.white : Colors.white60,
                    title: Text(comment.name),
                    subtitle: Text(comment.body),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                UpdateCommentShowDialog(context, comment);
                              },
                              icon: Icon(
                                Icons.create,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                DeleteCommentShowDialog(context, comment);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No comments available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateCommentshowDialog(context, com);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> CreateCommentshowDialog(
      BuildContext context, Comment comment) {
    var name = TextEditingController();
    var body = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create comment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(label: Text("name")),
              ),
              TextField(
                controller: body,
                decoration: InputDecoration(label: Text("body")),
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
                final comments = Comment(
                  postId: comment.postId,
                  id: comment.id,
                  name: name.text,
                  email: comment.email,
                  body: name.text,
                );
                context.read<CommentBloc>().add(CreareCommetEvent(comments));
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> DeleteCommentShowDialog(
      BuildContext context, Comment comment) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("delete comment"),
          content: Text("Are you want to delete this comment"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final comments = Comment(
                  postId: comment.postId,
                  id: comment.id,
                  name: comment.name,
                  email: comment.email,
                  body: comment.body,
                );
                context
                    .read<CommentBloc>()
                    .add(DeleteCommentEvent(comments.postId));
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> UpdateCommentShowDialog(
      BuildContext context, Comment comment) {
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
              final comments = Comment(
                postId: comment.postId,
                id: comment.id,
                name: comment.name,
                email: comment.email,
                body: body.text,
              );
              context.read<CommentBloc>().add(UpdateCommetEvent(comments));
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
