import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/strings/failure.dart';
import 'package:posts_app/features/posts/domain/usercases/get_all_posts_usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/post.dart';

part 'get_refresh_event.dart';
part 'get_refresh_state.dart';

class GetRefreshBloc extends Bloc<GetRefreshEvent, GetRefreshState> {
  GetAllPostsUseCase getAllPostsUseCase;
  GetRefreshBloc({required this.getAllPostsUseCase})
      : super(GetRefreshInitial()) {
    on<GetRefreshEvent>((event, emit) async {
      print('Get Refresh BLOC $event');
      //if (event is GetRefreshEvent || event is RefreshPostsEvent) {
      emit(LoadingPostsState());
      final res = await getAllPostsUseCase.call();
      res!.fold((failure) {
        emit(ErrorState(
            message: _mapFailureToMessage(failure),
            isLocal: (failure.runtimeType == EmptyCacheFailure)));
      }, (allPosts) {
        emit(LoadedPostsState(allPosts: allPosts));
      });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later . ';
    }
  }
}
