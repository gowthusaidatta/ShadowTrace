import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/aws_location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tracking_provider.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  late final AwsLocationService _aws;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final apiBase = const String.fromEnvironment('AWS_API_GATEWAY_URL', defaultValue: '');
    _aws = AwsLocationService(apiBase: apiBase);
    ref.read(trackingProvider.notifier).start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    ref.read(trackingProvider.notifier).stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trackingProvider);
    final markers = <Marker>[];
    if (state != null) {
      markers.add(Marker(point: LatLng(state.latitude, state.longitude), width: 60, height: 60, builder: (ctx) => const Icon(Icons.person_pin_circle, size: 48, color: Colors.cyan)));
    }

    final tileUrl = '${const String.fromEnvironment('AWS_API_GATEWAY_URL', defaultValue: '')}/location/getMapTile?mapName=${Uri.encodeComponent(const String.fromEnvironment('AWS_LOCATION_MAP_NAME', defaultValue: ''))}&z={z}&x={x}&y={y}';

    return Scaffold(
      appBar: AppBar(title: const Text('Live Tracking')),
      body: state == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(center: LatLng(state.latitude, state.longitude), zoom: 15.0),
              children: [
                TileLayer(urlTemplate: tileUrl, tileProvider: const NonCachingNetworkTileProvider()),
                MarkerLayer(markers: markers),
              ],
            ),
    );
  }
}
