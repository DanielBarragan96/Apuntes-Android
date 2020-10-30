part of 'noticias_bloc.dart';

abstract class NoticiasState extends Equatable {
  const NoticiasState();

  @override
  List<Object> get props => [];
}

class NoticiasInitialState extends NoticiasState {}

class NoticiasSucessState extends NoticiasState {
  final List<Noticia> noticiasSportList;
  final List<Noticia> noticiasBusinessList;

  NoticiasSucessState({
    @required this.noticiasSportList,
    @required this.noticiasBusinessList,
  });

  @override
  List<Object> get props => [noticiasSportList, noticiasBusinessList];
}

class NoticiasErrorState extends NoticiasState {
  final String msg;

  NoticiasErrorState({@required this.msg});

  @override
  List<Object> get props => [msg];
}
