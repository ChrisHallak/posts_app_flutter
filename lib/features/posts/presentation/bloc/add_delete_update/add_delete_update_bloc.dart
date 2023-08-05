import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/features/posts/domain/usercases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/update_post_usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/strings/failure.dart';
import '../../../domain/entities/post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddDeleteUpdateBloc(
      {required this.addPostUseCase,
      required this.deletePostUseCase,
      required this.updatePostUseCase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      emit(LoadingState());
      print('Add Delete Update BLOC $event');
      if (event is AddPostEvent) {
        final res = await addPostUseCase(event.post);
        _mapEitherToEmit(res, SUCCESS_ADD_POST_MESSAGE);
      } else if (event is DeletePostEvent) {
        final res = await deletePostUseCase(event.postId);
        _mapEitherToEmit(res, SUCCESS_DELETE_POST_MESSAGE);
      } else if (event is UpdatePostEvent) {
        final res = await updatePostUseCase(event.post);
        _mapEitherToEmit(res, SUCCESS_UPDATE_POST_MESSAGE);
      }
    });

//    on<ResetStateEvent>(_onResetState);
  }

  void _onResetState(
      ResetStateEvent event, Emitter<AddDeleteUpdateState> emit) async {
    print('dsfsdfsdfdsf');
    await Future.delayed(const Duration(milliseconds: 200));
    emit(AddDeleteUpdateInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    //print('The type of failure $failure.runtimeType');
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

  void _mapEitherToEmit(Either<Failure, Unit>? res, message) {
    res!.fold((failure) {
      emit(AddDeleteUpdateErrorState(message: _mapFailureToMessage(failure)));
    }, (unit) {
      emit(AddDeleteUpdateSuccessState(message: message));
    });
  }
}
