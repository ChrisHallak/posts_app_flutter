part of 'get_refresh_bloc.dart';

abstract class GetRefreshState extends Equatable {
  const GetRefreshState();

  @override
  List<Object> get props => [];
}

class GetRefreshInitial extends GetRefreshState {}

class LoadingPostsState extends GetRefreshState {}

class LoadedPostsState extends GetRefreshState {
  final List<Post> allPosts;
  LoadedPostsState({required this.allPosts}) {
    print('LOADED STATE IS CALLED');
  }
  @override
  List<Object> get props => [allPosts];
}

class ErrorState extends GetRefreshState {
  final String message;
  final bool isLocal;
  const ErrorState({required this.message, required this.isLocal});

  @override
  List<Object> get props => [message];
}
