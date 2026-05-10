import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';
import '../services/aws_location_service.dart';

class LocationState {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  LocationState(this.latitude, this.longitude, this.timestamp);
}

final trackingProvider = StateNotifierProvider<TrackingNotifier, LocationState?>((ref) => TrackingNotifier());

class TrackingNotifier extends StateNotifier<LocationState?> {
  Timer? _timer;
  final LocationService _locationService = LocationService();
  final AwsLocationService _aws = AwsLocationService(apiBase: const String.fromEnvironment('AWS_API_GATEWAY_URL', defaultValue: ''));
  TrackingNotifier(): super(null);

  void start({Duration interval = const Duration(seconds: 5)}) async {
    await _updateOnce();
    _timer = Timer.periodic(interval, (_) async => await _updateOnce());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _updateOnce() async {
    try {
      final locData = await _locationService.getCurrentPosition();
      state = LocationState(locData.latitude, locData.longitude, DateTime.now());
      // push to backend tracker
      await _aws.putTrackerPosition(
        const String.fromEnvironment('AWS_LOCATION_TRACKER_NAME', defaultValue: ''),
        'device-1',
        locData.latitude,
        locData.longitude,
      );
    } catch (e) {
      // ignore location errors
    }
  }
}
