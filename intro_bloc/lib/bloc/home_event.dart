part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends HomeEvent {
  final bool addElement;

  AddEvent({@required this.addElement});

  @override
  List<Object> get props => [];
}
