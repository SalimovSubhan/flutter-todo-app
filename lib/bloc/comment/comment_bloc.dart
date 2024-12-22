import 'package:app_test_alif/models/comment.dart';
import 'package:app_test_alif/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitialState()) {
    on<LoadCommentsEvent>(_onLoadComments);
    on<CreareCommetEvent>(_onCreateComments);
    on<UpdateCommetEvent>(_onUpdateComments);
    on<DeleteCommentEvent>(_onDeleteComments);
  }

  Future<void> _onLoadComments(
      LoadCommentsEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    try {
      List<Comment> comments =
          await commentRepository.fetchComments(event.postId);
      emit(CommentLoadedState(comments));
    } catch (e) {
      emit(CommentErrorState(e.toString()));
    }
  }

  Future _onCreateComments(
      CreareCommetEvent event, Emitter<CommentState> emit) async {
    try {
      await commentRepository.createComment(event.comment);
      add(LoadCommentsEvent(event.comment.postId));
    } catch (e) {
      emit(CommentErrorState(e.toString()));
    }
  }

  Future _onUpdateComments(
      UpdateCommetEvent event, Emitter<CommentState> emit) async {
    try {
      await commentRepository.updateComment(event.comment);
      add(LoadCommentsEvent(event.comment.postId));
    } catch (e) {
      emit(CommentErrorState(e.toString()));
    }
  }

  Future _onDeleteComments(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    try {
      await commentRepository.deleteComment(event.postId);
      add(LoadCommentsEvent(event.postId));
    } catch (e) {
      emit(CommentErrorState(e.toString()));
    }
  }
}
