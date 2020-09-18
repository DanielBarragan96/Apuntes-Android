import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Future<File> _pickImage() async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 720, //adapta imagen a maximo 720p de altura
      maxWidth: 720, //adapta imagen a maximo 720p de ancho
      imageQuality: 85, //reduce calidad de imagen al 85%
    );
    return File(chooseImage.path);
  }

  Future<bool> _checkBiometrics() async {
    try {
      // List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
      return _localAuth.canCheckBiometrics;
    } catch (e) {
      print(e.toString());
      // if (e.code == auth_error.notAvailable) {
      ////hacer algo
      // }
      return false;
    }
  }

  Future<bool> _authentication() async {
    try {
      return await _localAuth.authenticateWithBiometrics(
        localizedReason: "Ponga su huella dactilar",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
