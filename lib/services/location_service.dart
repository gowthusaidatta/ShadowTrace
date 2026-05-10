// Simple location service stub for demonstration
// In production, integrate platform channels or use location package

class LocationData {
  final double latitude;
  final double longitude;
  
  LocationData({required this.latitude, required this.longitude});
}

class LocationService {
  static const double _defaultLat = 37.7749;
  static const double _defaultLng = -122.4194;

  Future<LocationData> getCurrentPosition() async {
    // Stub: returns a default location
    // TODO: Integrate actual location provider (Google Play Services, Core Location, etc.)
    return LocationData(latitude: _defaultLat, longitude: _defaultLng);
  }

  Future<bool> isLocationEnabled() async {
    return true;
  }
}
