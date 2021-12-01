import 'dart:io';
import 'package:app/services/auth.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationService {
  Future<Position?> getPosition() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
    {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever)
    {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }
    else{
      return null;
    }
  }
}
