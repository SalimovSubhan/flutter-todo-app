import 'package:app_test_alif/models/comment.dart';

abstract class CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comment> comments;
  CommentLoadedState(this.comments);
}

class CommentErrorState extends CommentState {
  final String error;
  CommentErrorState(this.error);
}
