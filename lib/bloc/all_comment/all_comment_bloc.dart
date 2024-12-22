import 'dart:convert';
import 'package:app_test_alif/bloc/all_comment/all_comment_event.dart';
import 'package:app_test_alif/bloc/all_comment/all_comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AllCommentBloc extends Bloc<AllCommentsEvent, AllCommentState> {
  AllCommentBloc() : super(AllCommentInitialState()) {
    on<LoadCommentsEvent>(_getAllComments);
  }

  Future _getAllComments(
      LoadCommentsEvent event, Emitter<AllCommentState> emit) async {
    try {
      emit(AllCommentLoadingState());
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      if (response.statusCode == 200) {
        emit(AllCommentLoadedState(jsonDecode(response.body)));
      } else {
        emit(AllCommentErrorState("Ошибка ${response.statusCode}"));
      }
    } catch (e) {
      emit(AllCommentErrorState("Ошибка ${e}"));
    }
  }
}
