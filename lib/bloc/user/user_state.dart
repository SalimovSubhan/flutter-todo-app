import 'package:app_test_alif/models/user.dart';

abstract class UserState{}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserLoadedState extends UserState{
  final List<User> users;
  UserLoadedState(this.users);
}
class UserErrorState extends UserState{
  final String error;
  UserErrorState(this.error);
}