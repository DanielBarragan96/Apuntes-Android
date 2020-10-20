part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetDataEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends HomeEvent {
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends HomeEvent {
  final String materia;
  final String descripcion;
  final String imageUrl;

  SaveDataEvent({
    @required this.materia,
    @required this.descripcion,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [materia, descripcion, imageUrl];
}

class ChooseImageEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class UploadFileEvent extends HomeEvent {
  final File file;
  UploadFileEvent({@required this.file});
  @override
  List<Object> get props => [file];
}
