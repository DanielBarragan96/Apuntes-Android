import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

class HomeMap extends StatefulWidget {
  HomeMap({Key key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  bool _showMarker = false;
  Set<Marker> _mapMarkers = Set();
  GoogleMapController _mapController;
  Position _currentPosition;
  Position _defaultPosition =
      Position(longitude: 20.608148, latitude: -103.417576);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentPosition(),
      builder: (context, result) {
        if (result.error == null) {
          if (_currentPosition == null) _currentPosition = _defaultPosition;
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition.latitude,
                      _currentPosition.longitude,
                    ),
                  ),
                  onMapCreated: _onMapCreated,
                  markers: _mapMarkers,
                  onLongPress: _setMarker,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Share.share(
                  "$_currentPosition",
                  subject: "Aqui me encuentro",
                );
              },
              child: Icon(Icons.share),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("Se ha producido un error"),
            ),
          );
        }
      },
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _setMarker(LatLng coord) async {
    // get address
    String _markerAddress = await _getGeoCodingAddress(
      Position(
        latitude: coord.latitude,
        longitude: coord.longitude,
      ),
    );
    _showMarker = true;
    setState(
      () {
        _mapMarkers.add(
          Marker(
            markerId: MarkerId(coord.toString()),
            position: coord,
            infoWindow: InfoWindow(
              title: coord.toString(),
              snippet: _markerAddress,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          ),
        );
      },
    );

    // move camera
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            coord.latitude,
            coord.longitude,
          ),
          zoom: 10.0,
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    //verify permission
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await requestPermission();
    }

    // get current position
    _currentPosition =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // get address
    String _currentAddress = await _getGeoCodingAddress(_currentPosition);

    //add marker
    _mapMarkers.add(
      Marker(
        markerId: MarkerId(_currentPosition.toString()),
        position: LatLng(
          _currentPosition.latitude,
          _currentPosition.longitude,
        ),
        infoWindow: InfoWindow(
          title: _currentPosition.toString(),
          snippet: _currentAddress,
        ),
      ),
    );

    // move camera
    if (!_showMarker) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition.latitude,
              _currentPosition.longitude,
            ),
            zoom: 8.0,
          ),
        ),
      );
    }
  }

  Future<String> _getGeoCodingAddress(Position position) async {
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (places != null) {
      final Placemark place = places.first;
      return "${place.thoroughfare}, ${place.locality}";
    }
    return "No address available";
  }
}
