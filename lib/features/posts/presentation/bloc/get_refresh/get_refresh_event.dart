part of 'get_refresh_bloc.dart';

abstract class GetRefreshEvent extends Equatable {
  const GetRefreshEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends GetRefreshEvent {}

class RefreshPostsEvent extends GetRefreshEvent {}
