// user_event.dart

import 'package:app_test_alif/models/user.dart';

abstract class UserEvent {}

class LoadUsersEvent extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;
  CreateUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent(this.user);
}

class DeleteUserEvent extends UserEvent {
  final int userId;
  DeleteUserEvent(this.userId);
}
