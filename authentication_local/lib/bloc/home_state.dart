part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadedImageState extends HomeState {
  final File image;

  LoadedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

class AuthenticationDoneState extends HomeState {
  @override
  List<Object> get props => [];
}

class AuthenticationErrorState extends HomeState {
  final String message;

  AuthenticationErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
