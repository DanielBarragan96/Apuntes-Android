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
      bool dataRetrieved = await _getAllApuntes();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(errorMessage: "No se pudo recuperar datos");
    } else if (event is SaveDataEvent) {
      bool saved =
          await _saveApunte(event.materia, event.descripcion, event.imageUrl);
      if (saved) {
        await _getAllApuntes();
        yield CloudStoreGetData();
      } else {
        yield CloudStoreError(
            errorMessage:
                "Ha ocurrido un error inesperado. Intente guardar mas tarde");
      }
    } else if (event is UploadFileEvent) {
      File _chosenImage = await _chooseImage();
      if (_chosenImage != null) {}
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
    //Referencia al storage de Firebase
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("apuntes/${Path.basename(imagePath)}");
    //Subir archivo a Firebase
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;
    //Recuperar la url del archivo que acabamos de subir
    dynamic imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<bool> _saveApunte(
      String materia, String descripcion, String imageUrl) async {
    try {
      //Crea un documento en la collection de apuntes
      await FirebaseFirestore.instance.collection("apuntes").doc().set({
        "materia": materia,
        "descripcion": descripcion,
        "imageUrl": imageUrl
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> _getAllApuntes() async {
    try {
      // recuperar lista de documentos guardados enn cloud FireStore
      var apuntes =
          await FirebaseFirestore.instance.collection("apuntes").get();
      _apuntesList = apuntes.docs
          //mapear a objeto de dart (Apunte)
          .map((element) => Apunte(
                materia: element["materia"],
                descripcion: element["descripcion"],
                imageUrl: element["imageUrl"],
              ))
          //agregar objetos a una lista
          .toList();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
