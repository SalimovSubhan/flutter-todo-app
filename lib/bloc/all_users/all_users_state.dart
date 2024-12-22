abstract class AllUsersState {}

class AllUsesrInitialState extends AllUsersState {}

class AllUsersLoadingState extends AllUsersState {}

class AllUsesrLoadedState extends AllUsersState {
  final List<dynamic> allUsers;
  AllUsesrLoadedState(this.allUsers);
}

class AllUsesrErrorState extends AllUsersState {
  final String error;
  AllUsesrErrorState(this.error);
}
