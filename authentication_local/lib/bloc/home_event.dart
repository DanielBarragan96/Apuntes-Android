part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadImageEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class OpenLinkEvent extends HomeEvent {
  final String url;

  OpenLinkEvent({@required this.url});
  @override
  List<Object> get props => [url];
}
