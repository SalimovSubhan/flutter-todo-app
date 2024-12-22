import 'package:app_test_alif/bloc/all_posts/all_posts_bloc.dart';
import 'package:app_test_alif/bloc/all_posts/all_posts_event.dart';
import 'package:app_test_alif/bloc/all_posts/all_posts_state.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllPostsBloc>().add(LoadAllPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          "All posts",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<AllPostsBloc, AllPostState>(
        builder: (context, state) {
          if (state is AllPostLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllPostLoadedState) {
            final posts = state.allPost;
            return ListView.builder(
              itemCount: state.allPost.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  child: ListTile(
                    tileColor: darkOrwhite ? Colors.grey : Colors.blueGrey,
                    textColor: darkOrwhite ? Colors.white : Colors.white60,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Title:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 250,
                          child: Text(post["title"]),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Body:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 250,
                              child: Text(post["body"]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Text("Нету лудей тут");
        },
        listener: (context, state) {
          if (state is AllPostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
      ),
    );
  }
}
