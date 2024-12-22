import 'dart:convert';

import 'package:app_test_alif/bloc/all_posts/all_posts_event.dart';
import 'package:app_test_alif/bloc/all_posts/all_posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AllPostsBloc extends Bloc<AllPostEvent, AllPostState> {
  AllPostsBloc() : super(AllPostInitialState()) {
    on<LoadAllPostEvent>(_getAllUsesr);
  }

  Future _getAllUsesr(
      LoadAllPostEvent event, Emitter<AllPostState> emit) async {
    try {
      emit(AllPostLoadingState());
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        emit(AllPostLoadedState(jsonDecode(response.body)));
      } else {
        emit(AllPostErrorState("Ошибка ${response.statusCode}"));
      }
    } catch (e) {
      emit(AllPostErrorState("Ошибка ${e}"));
    }
  }
}
