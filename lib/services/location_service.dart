import 'package:geolocator/geolocator.dart';
import 'package:pro_coach/models/coach.dart';

class LocationService {
  static String gymUrl = '';

  static Future<String> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return 'Location is Not Enabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return 'Location Denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return 'Enable Location From Settings';
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    String lat = '';
    String lng = '';

    await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude.toString();
      lng = value.longitude.toString();
    });
    gymUrl = 'https://maps.google.com/?q=$lat,$lng';
    Coach.gymUrl = gymUrl;
    return 'Locate Successfully';
  }
}
