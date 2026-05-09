import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getCurrentPosition() async {
    try {
      final result = await _location.getLocation();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLocationEnabled() async {
    return await _location.serviceEnabled();
  }

  Stream<LocationData> getLocationStream() {
    return _location.onLocationChanged;
  }
}
