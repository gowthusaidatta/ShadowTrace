import 'dart:async';
import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:torch_light/torch_light.dart';
import 'notification_service.dart';

class SosService {
  final AudioPlayer _player = AudioPlayer();
  final Dio _dio = Dio();

  Future<void> triggerSos({required double lat, required double lon, required String userId}) async {
    // Play siren in loop
    try {
      await _player.setAsset('assets/sounds/siren.mp3');
      _player.setLoopMode(LoopMode.one);
      _player.play();
    } catch (e) {
      // ignore missing asset
    }

    // Flashlight blinking
    _blinkFlashlight();

    // Show local full-screen notification
    await NotificationService().showLocalSosAlert(title: 'SOS Activated', body: 'Live location is being shared');

    // Send to backend
    final api = const String.fromEnvironment('AWS_API_GATEWAY_URL', defaultValue: '');
    if (api.isNotEmpty) {
      try {
        await _dio.post('$api/sos', data: {'userId': userId, 'location': {'lat': lat, 'lon': lon}, 'timestamp': DateTime.now().toIso8601String()});
      } catch (e) {
        // attempt SMS fallback could be implemented here
      }
    }
  }

  Future<void> _blinkFlashlight() async {
    Timer.periodic(const Duration(milliseconds: 600), (timer) async {
      try {
        if (timer.tick % 2 == 0) {
          await TorchLight.enableTorch();
        } else {
          await TorchLight.disableTorch();
        }
      } catch (e) {
        timer.cancel();
      }
    });
  }

  Future<void> stopSos() async {
    await _player.stop();
    try { await TorchLight.disableTorch(); } catch (e) {}
  }
}
