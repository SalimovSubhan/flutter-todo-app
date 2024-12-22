import 'package:app_test_alif/bloc/all_users/all_users_bloc.dart';
import 'package:app_test_alif/bloc/all_users/all_users_event.dart';
import 'package:app_test_alif/bloc/all_users/all_users_state.dart';
import 'package:app_test_alif/screens/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllUsesrBloc>().add(LoadAllUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          "All users",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<AllUsesrBloc, AllUsersState>(
        builder: (context, state) {
          if (state is AllUsersLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllUsesrLoadedState) {
            final users = state.allUsers;
            return ListView.builder(
              itemCount: state.allUsers.length,
              itemBuilder: (context, index) {
                final user = users[index];
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
                          width: 0,
                        ),
                        Text(user["name"]),
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
                            Text(user["email"]),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Phone:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(user["phone"]),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Website:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(user["website"]),
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
          if (state is AllUsesrErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
      ),
    );
  }
}
