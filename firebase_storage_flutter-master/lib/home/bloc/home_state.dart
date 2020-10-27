part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class DataSavedErrorState extends HomeState {
  final String errorMessage;

  DataSavedErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class DataRemovedState extends HomeState {
  @override
  List<Object> get props => [];
}

class DataSavedState extends HomeState {
  @override
  List<Object> get props => [];
}

class DataFetchingState extends HomeState {
  @override
  List<Object> get props => [];
}

class DataRetrievedState extends HomeState {
  @override
  List<Object> get props => [];
}

class ChosenImageLoaded extends HomeState {
  final File imgPath;
  ChosenImageLoaded({@required this.imgPath});
  @override
  List<Object> get props => [imgPath];
}

class ChosenImageFailedState extends HomeState {
  @override
  List<Object> get props => [];
}

class FileUploadedState extends HomeState {
  final dynamic fileUrl;
  FileUploadedState({@required this.fileUrl});
  @override
  List<Object> get props => [fileUrl];
}

class FileUploadFailedState extends HomeState {
  @override
  List<Object> get props => [];
}
