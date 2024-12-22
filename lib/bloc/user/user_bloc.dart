import 'package:app_test_alif/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:app_test_alif/models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitialState()) {
    on<LoadUsersEvent>(_onLoadUsersEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
  }

  Future<void> _onLoadUsersEvent(
      LoadUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      List<User> users = await userRepository.fetchUsers();

      emit(UserLoadedState(users));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.createUser(event.user);
      add(LoadUsersEvent());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateUserEvent(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.updateUser(event.user);
      add(LoadUsersEvent());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteUserEvent(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.deleteUser(event.userId);
      add(LoadUsersEvent());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
