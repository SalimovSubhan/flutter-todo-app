abstract class AllPostState {}

class AllPostInitialState extends AllPostState {}

class AllPostLoadingState extends AllPostState {}

class AllPostLoadedState extends AllPostState {
  final List<dynamic> allPost;
  AllPostLoadedState(this.allPost);
}

class AllPostErrorState extends AllPostState {
  final String error;
  AllPostErrorState(this.error);
}
