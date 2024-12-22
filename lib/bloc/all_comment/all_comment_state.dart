abstract class AllCommentState {}

class AllCommentInitialState extends AllCommentState {}

class AllCommentLoadingState extends AllCommentState {}

class AllCommentLoadedState extends AllCommentState {
  final List<dynamic> allComments;
  AllCommentLoadedState(this.allComments);
}

class AllCommentErrorState extends AllCommentState {
  final String error;
  AllCommentErrorState(this.error);
}
