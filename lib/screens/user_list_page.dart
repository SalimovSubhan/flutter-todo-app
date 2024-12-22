import 'package:app_test_alif/bloc/user/user_bloc.dart';
import 'package:app_test_alif/bloc/user/user_event.dart';
import 'package:app_test_alif/bloc/user/user_state.dart';
import 'package:app_test_alif/screens/carta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test_alif/models/user.dart';

var LocalUser;
var darkOrwhite = false;
var lat;
var lng;

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrwhite == false ? Colors.grey : Colors.blueGrey,
        title: Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Switch(
            activeColor: Colors.white,
            thumbIcon: WidgetStateProperty.all(
              Icon(
                darkOrwhite ? Icons.nightlight_round : Icons.wb_sunny,
                color: darkOrwhite ? Colors.black : Colors.yellow,
              ),
            ),
            value: darkOrwhite,
            onChanged: (value) {
              setState(() {
                darkOrwhite = !darkOrwhite;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<UserBloc>().add(LoadUsersEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          } else if (state is UserLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Users updated')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoadedState) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                LocalUser = user;
                lat = user.address["geo"]["lat"];
                lng = user.address["geo"]["lng"];
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
                        Text(user.name),
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
                            Text(user.email),
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
                            Text(user.phone),
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
                            Text(user.website),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Carta(
                                            Lat: lat,
                                            Lng: lng,
                                          )));
                            },
                            child: Text("Adress")),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _showEditUserDialog(context, user);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, user);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/posts',
                        arguments: user.id,
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No users available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddUserDialog(context, LocalUser);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> AddUserDialog(BuildContext context, User user) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final websiteController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text("name"),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("email"),
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                label: Text("phone"),
              ),
            ),
            TextField(
              controller: websiteController,
              decoration: InputDecoration(
                label: Text("website"),
              ),
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
                final addUser = User(
                    id: user.id,
                    name: nameController.text,
                    email: emailController.text,
                    address: user.address,
                    phone: phoneController.text,
                    website: websiteController.text);
                context.read<UserBloc>().add(CreateUserEvent(addUser));
                Navigator.of(context).pop();
              },
              child: Text("Save"))
        ],
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, User user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);
    final websiteController = TextEditingController(text: user.website);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: websiteController,
              decoration: InputDecoration(labelText: 'Website'),
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
              final updatedUser = User(
                id: user.id,
                name: nameController.text,
                email: emailController.text,
                address: user.address,
                phone: phoneController.text,
                website: websiteController.text,
              );
              context.read<UserBloc>().add(UpdateUserEvent(updatedUser));
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, User user) {
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
              context.read<UserBloc>().add(DeleteUserEvent(user.id));
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
