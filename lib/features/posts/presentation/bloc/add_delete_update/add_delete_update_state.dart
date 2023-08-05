part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingState extends AddDeleteUpdateState {}

class AddDeleteUpdateSuccessState extends AddDeleteUpdateState {
  final String message;
  const AddDeleteUpdateSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class AddDeleteUpdateErrorState extends AddDeleteUpdateState {
  final String message;
  const AddDeleteUpdateErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
