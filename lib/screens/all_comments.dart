import 'package:app_test_alif/bloc/all_comment/all_comment_bloc.dart';
import 'package:app_test_alif/bloc/all_comment/all_comment_event.dart';
import 'package:app_test_alif/bloc/all_comment/all_comment_state.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllComments extends StatefulWidget {
  const AllComments({super.key});

  @override
  State<AllComments> createState() => _AllCommentsState();
}

class _AllCommentsState extends State<AllComments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllCommentBloc>().add(LoadCommentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          "All Comments",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<AllCommentBloc, AllCommentState>(
        builder: (context, state) {
          if (state is AllCommentLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllCommentLoadedState) {
            final comments = state.allComments;
            return ListView.builder(
              itemCount: state.allComments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  child: ListTile(
                    tileColor: darkOrwhite ? Colors.grey : Colors.blueGrey,
                    textColor: darkOrwhite ? Colors.white : Colors.white60,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 250,
                          child: Text(comment["name"]),
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
                              "Email:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Text(comment["email"]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Body:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 280,
                              child: Text(comment["body"]),
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
          if (state is AllCommentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
      ),
    );
  }
}
