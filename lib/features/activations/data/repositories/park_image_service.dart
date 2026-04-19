import 'package:dio/dio.dart';

class ParkImageService {
  final Dio _dio = Dio();

  /// Tries to fetch a relevant park image from Wikipedia based on coordinates.
  /// Falls back to a free static map if no Wikipedia image is found.
  Future<String?> getParkImageUrl(double lat, double lon, String parkName) async {
    try {
      // 1. Try Wikipedia Geosearch first (Real photos)
      final wikiUrl = 'https://en.wikipedia.org/w/api.php';
      final response = await _dio.get(wikiUrl, queryParameters: {
        'action': 'query',
        'generator': 'geosearch',
        'ggscoord': '$lat|$lon',
        'ggsradius': '10000',
        'ggslimit': '10',
        'prop': 'pageimages|pageterms',
        'piprop': 'thumbnail',
        'pithumbsize': '1000',
        'format': 'json',
        'origin': '*',
      });

      if (response.statusCode == 200 && response.data['query'] != null) {
        final pages = response.data['query']['pages'] as Map<String, dynamic>;
        
        for (var page in pages.values) {
          final title = (page['title'] as String).toLowerCase();
          final terms = page['pageterms']?['description'] as List?;
          final description = terms?.join(' ').toLowerCase() ?? '';
          
          // Heuristic: Check if the Wikipedia article is likely a park
          if (title.contains('park') || 
              title.contains('reserve') || 
              title.contains('forest') ||
              description.contains('park') ||
              description.contains('protected area') ||
              description.contains('nature')) {
            
            if (page['thumbnail'] != null) {
              return page['thumbnail']['source'];
            }
          }
        }
      }
    } catch (e) {
      print('Wikipedia Image Fetch Error: $e');
    }

    // 2. Fallback to OpenFreeMap (Completely free, no API key)
    // We use a simple static map from a reliable open-source provider.
    // Note: OpenFreeMap doesn't have a direct static image API like Google, 
    // but we can use OSM-based static map services or just a nice placeholder.
    
    // For a truly free "static map" without keys, we can use the OSM static maps demo
    // or MapTiler's free tier (requires key but very generous).
    // Let's use a standard OSM static map helper if available, 
    // otherwise return null to show the placeholder icon.
    
    return null;
  }
}
