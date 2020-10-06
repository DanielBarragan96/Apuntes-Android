part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadedDataState extends HomeState {
  final Map<String, dynamic> configs;

  LoadedDataState(@required this.configs);
  @override
  List<Object> get props => [configs];
}

class ErrorState extends HomeState {
  final String errorMessage;

  ErrorState(@required this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
