import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
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
    final styleUrl = _isDark
        ? 'https://mapmaker.tomtom.com/preview/styles/dG9tdG9tQEBAYnEwVlgyemp1blVqcW8yejsH8V5d3YlK4LYUd9Fz8SAp/0?key=${ApiKeys.tomTomMapKey}'
        : 'https://api.tomtom.com/style/2/custom/style/dG9tdG9tQEBAYnEwVlgyemp1blVqcW8yejt7Po8emulO-rW268nlS_XQ/drafts/0.json?key=${ApiKeys.tomTomMapKey}';

    try {
      final style = await StyleReader(
        uri: styleUrl,
      ).read();

      if (mounted) {
        setState(() {
          _style = style;
        });
      }
    } catch (e) {
      // Fallback or error handling
      debugPrint('Error loading vector style: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

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
                    color: AppColors.primaryGreen.withOpacity(0.4),
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
                      color: AppColors.primaryGreen.withOpacity(0.85),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withOpacity(0.3),
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
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurface.withOpacity(0.85)
                  : Colors.white.withOpacity(0.9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border(
                top: BorderSide(
                  color: AppColors.primaryGreen.withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.subtext(brightness).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Accent strip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGreen.withOpacity(0.15),
                        AppColors.secondaryGreen.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    park.reference.isNotEmpty ? park.reference : 'No Reference',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  park.name.isNotEmpty ? park.name : 'Unknown Park',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkOnSurface : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.subtext(brightness),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      park.state.isNotEmpty ? park.state : 'Unknown State',
                      style: TextStyle(color: AppColors.subtext(brightness)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
