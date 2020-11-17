part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class CarrosListState extends HomeState {
  final List<Map<String, dynamic>> misCarrosList;

  CarrosListState({@required this.misCarrosList});
}

class UpdatedSuccessState extends HomeState {}

class UpdatedErrorState extends HomeState {}
