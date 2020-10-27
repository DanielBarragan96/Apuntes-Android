import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_app/model/apunte.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Apunte> _apuntesList;
  List<DocumentSnapshot> _documentsList;
  List<Apunte> get getApuntesList => _apuntesList;

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataEvent) {
      try {
        yield DataFetchingState();
        await _getAllApuntes();
        yield DataRetrievedState();
      } catch (e) {
        yield DataSavedErrorState(errorMessage: "No se pudo recuperar datos");
      }
    } else if (event is SaveDataEvent) {
      try {
        await _saveApunte(
          event.materia,
          event.descripcion,
          event.imageUrl,
        );
        _apuntesList.add(
          Apunte(
            materia: event.materia,
            descripcion: event.descripcion,
            imageUrl: event.imageUrl,
          ),
        );

        yield DataSavedState();
        yield DataRetrievedState();
      } catch (e) {
        yield DataSavedErrorState(
          errorMessage:
              "Ha ocurrido un error ineperado. Intente guardar mas tarde",
        );
      }
    } else if (event is UploadFileEvent) {
      try {
        String imageUrl = await _uploadPicture(event.file);
        if (imageUrl != null)
          yield FileUploadedState(fileUrl: imageUrl);
        else
          yield FileUploadFailedState();
      } catch (e) {
        yield FileUploadFailedState();
      }
    } else if (event is ChooseImageEvent) {
      File chosenImage = await _chooseImage();
      if (chosenImage == null)
        yield ChosenImageFailedState();
      else
        yield ChosenImageLoaded(imgPath: chosenImage);
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        await _getAllApuntes();

        // _documentsList.removeAt(event.index);
        // _apuntesList.removeAt(event.index);
        yield DataRemovedState();
      } catch (e) {
        yield DataSavedErrorState(errorMessage: "No se pudo eliminar..");
      }
    }
  }

  Future<File> _chooseImage() async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chooseImage.path);
  }

  Future<String> _uploadPicture(File image) async {
    String imagePath = image.path;
    // referencia al storage de firebase
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("apuntes/${Path.basename(imagePath)}");

    // subir el archivo a firebase
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;

    // recuperar la url del archivo que acabamos de subir
    dynamic imageURL = await reference.getDownloadURL();
    return imageURL;
  }

  Future _saveApunte(
    String materia,
    String descripcion,
    String imageUrl,
  ) async {
    // Crea un doc en la collection de apuntes

    await FirebaseFirestore.instance.collection("apuntes").doc().set({
      "materia": materia,
      "descripcion": descripcion,
      "imagen": imageUrl,
    });
  }

  Future _getAllApuntes() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (Apunte)
    // agregar cada ojeto a una lista
    var apuntes = await FirebaseFirestore.instance.collection("apuntes").get();
    _documentsList = apuntes.docs;
    _apuntesList = apuntes.docs
        .map(
          (elemento) => Apunte(
            materia: elemento["materia"],
            descripcion: elemento["descripcion"],
            imageUrl: elemento["imagen"],
          ),
        )
        .toList();
  }
}
