import 'package:app_test_alif/screens/all_comments.dart';
import 'package:app_test_alif/screens/all_posts.dart';
import 'package:app_test_alif/screens/all_users.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';

class BottomNavigators extends StatefulWidget {
  const BottomNavigators({super.key});

  @override
  State<BottomNavigators> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigators> {
  int index = 0;
  List screens = [
    UserListPage(),
    AllUsers(),
    AllPosts(),
    AllComments(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.blue[200],
          currentIndex: index,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_open_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_sharp), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.comment_outlined), label: ""),
          ]),
    );
  }
}
