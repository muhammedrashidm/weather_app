import 'package:location/location.dart';

class MyLocation {
  static Future<LocationData?> getLocation() async {
    try {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {}
      }
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {}
      }
      locationData = await location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        return locationData;
      }
    } catch (err, stack) {}
    return null;
  }
}
