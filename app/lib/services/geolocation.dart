import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationService {
  //Gets permission from user to get location
  Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  //Gets permission from user and finds current location
  Future<Position?> getPosition() async {
    LocationPermission permission = await requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } else {
      return null;
    }
  }

  //Finds distance between passed lat/long and current position
  Future<double> getDistance(double latitude, double longitude) async {
    LocationPermission permission = await requestPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return Geolocator.distanceBetween(
          latitude, longitude, position.latitude, position.longitude);
    } else {
      return 0;
    }
  }

  getPlaceMark(double latitude, double longitude) async {
    List<Placemark> places =
        await placemarkFromCoordinates(latitude, longitude);
    String? name = places.first.locality;

    return name;
  }
}
