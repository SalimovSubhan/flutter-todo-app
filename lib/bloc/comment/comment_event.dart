

import 'package:app_test_alif/models/comment.dart';

abstract class CommentEvent {}

class LoadCommentsEvent extends CommentEvent {
  final int postId;
  LoadCommentsEvent(this.postId);
}
class CreareCommetEvent extends CommentEvent{
  final Comment comment;
  CreareCommetEvent(this.comment);
}
class UpdateCommetEvent extends CommentEvent{
  final Comment comment;
  UpdateCommetEvent(this.comment);
}
class DeleteCommentEvent extends CommentEvent{
  final int postId;
DeleteCommentEvent(this.postId);
}
