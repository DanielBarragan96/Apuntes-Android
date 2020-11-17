part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCarrosEvent extends HomeEvent {}

class UpdateEvent extends HomeEvent {
  final Map<String, dynamic> newData;
  final String elementId;

  UpdateEvent({@required this.newData, @required this.elementId});
  @override
  List<Object> get props => [newData, elementId];
}
