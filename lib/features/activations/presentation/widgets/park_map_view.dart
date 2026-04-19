import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/park.dart';
import '../../../../core/secrets/api_keys.dart';

class ParkMapView extends ConsumerStatefulWidget {
  final List<Park> parks;

  const ParkMapView({super.key, required this.parks});

  @override
  ConsumerState<ParkMapView> createState() => _ParkMapViewState();
}

class _ParkMapViewState extends ConsumerState<ParkMapView> {
  Style? _style;
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    
    if (_style == null || _isDark != isDark) {
      _isDark = isDark;
      _loadStyle();
    }
  }

  Future<void> _loadStyle() async {
    final lightUrl = 'https://api.tomtom.com/style/2/custom/style/dG9tdG9tQEBAYnEwVlgyemp1blVqcW8yejt7Po8emulO-rW268nlS_XQ/drafts/0.json?key=${ApiKeys.tomTomMapKey}';
    // Fixed dark style URL to match the working light style pattern
    final darkUrl = 'https://api.tomtom.com/style/2/custom/style/dG9tdG9tQEBAYnEwVlgyemp1blVqcW8yejsH8V5d3YlK4LYUd9Fz8SAp/drafts/0.json?key=${ApiKeys.tomTomMapKey}';

    final styleUrl = _isDark ? darkUrl : lightUrl;

    try {
      final style = await StyleReader(
        uri: styleUrl,
      ).read().timeout(const Duration(seconds: 10));

      if (mounted) {
        setState(() {
          _style = style;
        });
      }
    } catch (e) {
      debugPrint('Error loading vector style: $e');
      // Fallback to light style if dark fails to load
      if (_isDark) {
        try {
          final fallbackStyle = await StyleReader(
            uri: lightUrl,
          ).read();
          if (mounted) {
            setState(() {
              _style = fallbackStyle;
            });
          }
        } catch (e2) {
          debugPrint('Error loading fallback style: $e2');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final markers = widget.parks.where((p) {
      final lat = p.latitude;
      final lon = p.longitude;
      if (lat == null || lon == null) return false;
      if (lat.isNaN || lon.isNaN) return false;
      if (lat < -90.0 || lat > 90.0) return false;
      if (lon < -180.0 || lon > 180.0) return false;
      return true;
    }).map((p) {
      try {
        return Marker(
          width: 36.0,
          height: 36.0,
          point: LatLng(p.latitude!, p.longitude!),
          child: GestureDetector(
            onTap: () => _showParkDetails(context, p),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.park_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        );
      } catch (e) {
        return null;
      }
    }).whereType<Marker>().toList();

    return _style == null
        ? Center(child: CircularProgressIndicator(color: AppColors.primaryGreen))
        : FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(20.0, 0.0),
              initialZoom: 2.0,
              maxZoom: 18.0,
            ),
            children: [
              VectorTileLayer(
                theme: _style!.theme,
                sprites: _style!.sprites,
                tileProviders: _style!.providers,
              ),
              SuperclusterLayer.mutable(
                initialMarkers: markers,
                clusterWidgetSize: const Size(44, 44),
                builder: (context, position, clusterCount, extraData) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.primaryGreen.withValues(alpha: 0.85),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        clusterCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }

  void _showParkDetails(BuildContext context, Park park) {
    context.push('/park-detail', extra: park);
  }
}
