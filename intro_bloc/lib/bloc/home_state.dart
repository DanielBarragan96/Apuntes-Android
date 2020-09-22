part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class CounterModifyState extends HomeState {
  final int counter;

  CounterModifyState({@required this.counter});

  @override
  List<Object> get props => [counter];
}
