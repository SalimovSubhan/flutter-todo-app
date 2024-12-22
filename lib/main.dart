import 'package:app_test_alif/bloc/all_comment/all_comment_bloc.dart';
import 'package:app_test_alif/bloc/all_posts/all_posts_bloc.dart';
import 'package:app_test_alif/bloc/all_users/all_users_bloc.dart';
import 'package:app_test_alif/bloc/comment/comment_bloc.dart';
import 'package:app_test_alif/bloc/post/post_bloc.dart';
import 'package:app_test_alif/bloc/user/user_bloc.dart';
import 'package:app_test_alif/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test_alif/repository/user_repository.dart';
import 'package:app_test_alif/repository/post_repository.dart';
import 'package:app_test_alif/repository/comment_repository.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:app_test_alif/screens/post_list_page.dart';
import 'package:app_test_alif/screens/comment_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserBloc(UserRepository()),
        ),
        BlocProvider(
          create: (_) => PostBloc(PostRepository()),
        ),
        BlocProvider(
          create: (_) => CommentBloc(CommentRepository()),
        ),
        BlocProvider(
          create: (_) => AllUsesrBloc(),
        ),
        BlocProvider(
          create: (_) => AllPostsBloc(),
        ),
        BlocProvider(
          create: (_) => AllCommentBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App with BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/botomnavigator',
        routes: {
          '/botomnavigator': (context) => BottomNavigators(),
          '/users': (context) => UserListPage(),
          '/posts': (context) => PostListPage(
              userId: ModalRoute.of(context)!.settings.arguments as int),
          '/comments': (context) => CommentListPage(
              postId: ModalRoute.of(context)!.settings.arguments as int),
        },
      ),
    );
  }
}
