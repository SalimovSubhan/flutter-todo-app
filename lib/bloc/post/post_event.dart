import 'package:app_test_alif/models/post.dart';

abstract class PostEvent {}

class LoadPostsEvent extends PostEvent {
  final int userId;
  LoadPostsEvent(this.userId);
}

class CreatePostEvent extends PostEvent{
  final Post post;
  CreatePostEvent(this.post);
}

class UpdatePostEvent extends PostEvent {
  final Post post;
  UpdatePostEvent(this.post);
}

class DeletePostEvent extends PostEvent {
  final int postId;
  DeletePostEvent(this.postId);
}
