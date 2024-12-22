import 'dart:convert';

import 'package:app_test_alif/bloc/all_users/all_users_event.dart';
import 'package:app_test_alif/bloc/all_users/all_users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AllUsesrBloc extends Bloc<AllUsersEvent, AllUsersState> {
  AllUsesrBloc() : super(AllUsesrInitialState()) {
    on<LoadAllUsersEvent>(_getAllUsesr);
  }

  Future _getAllUsesr(
      LoadAllUsersEvent event, Emitter<AllUsersState> emit) async {
    try {
      emit(AllUsersLoadingState());
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (response.statusCode == 200) {
        emit(AllUsesrLoadedState(jsonDecode(response.body)));
      } else {
        emit(AllUsesrErrorState("Ошибка ${response.statusCode}"));
      }
    } catch (e) {
      emit(AllUsesrErrorState("Ошибка ${e}"));
    }
  }
}
