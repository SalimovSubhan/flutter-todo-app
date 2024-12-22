import 'package:app_test_alif/models/post.dart';
import 'package:app_test_alif/repository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitialState()) {
    on<LoadPostsEvent>(_onLoadPostsEvent);
    on<CreatePostEvent>(_onCreatPostsEvent);
    on<UpdatePostEvent>(_onUpdatePostsEvent);
    on<DeletePostEvent>(_onDeletePostsEvent);
  }

  Future<void> _onLoadPostsEvent(
      LoadPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      List<Post> posts = await postRepository.fetchPosts(event.userId);
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future _onCreatPostsEvent(CreatePostEvent event ,Emitter<PostState> emit)async
  {
    try {
      await postRepository.createPost(event.post);
      add(LoadPostsEvent(event.post.userId));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future _onUpdatePostsEvent(UpdatePostEvent event,Emitter<PostState> emit)async
  {
    try {
      await postRepository.updatePost(event.post);
      add(LoadPostsEvent(event.post.userId));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future _onDeletePostsEvent(DeletePostEvent event,Emitter<PostState> emit)async
  {
   try {
     await postRepository.deletePost(event.postId);
     add(DeletePostEvent(event.postId));
   } catch (e) {
     emit(PostErrorState(e.toString()));
   }
  }
}
