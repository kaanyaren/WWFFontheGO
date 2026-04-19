import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../../../core/theme/gradient_background.dart';
import '../../domain/models/park.dart';
import '../../data/repositories/park_image_service.dart';

class ParkDetailPage extends HookWidget {
  final Park park;

  const ParkDetailPage({super.key, required this.park});

  Future<void> _launchNavigation() async {
    if (park.latitude == null || park.longitude == null) return;
    
    final url = 'google.navigation:q=${park.latitude},${park.longitude}';
    final fallbackUrl = 'https://www.google.com/maps/search/?api=1&query=${park.latitude},${park.longitude}';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    
    final imageUrlState = useState<String?>(null);
    final isLoadingImage = useState(true);

    useEffect(() {
      if (park.latitude != null && park.longitude != null) {
        ParkImageService().getParkImageUrl(park.latitude!, park.longitude!, park.name).then((url) {
          imageUrlState.value = url;
          isLoadingImage.value = false;
        });
      } else {
        isLoadingImage.value = false;
      }
      return null;
    }, [park.id]);

    // Fallback Static Map using Yandex (Completely free, no key needed for simple usage)
    final String osmStaticUrl = park.latitude != null && park.longitude != null
        ? 'https://static-maps.yandex.ru/1.x/?ll=${park.longitude},${park.latitude}&z=13&l=map&size=600,400'
        : '';

    return Scaffold(
      body: GradientBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'park-image-${park.reference}',
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (imageUrlState.value != null)
                        Image.network(
                          imageUrlState.value!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildFallbackMap(osmStaticUrl),
                        )
                      else if (isLoadingImage.value)
                        Container(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          child: const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen)),
                        )
                      else
                        _buildFallbackMap(osmStaticUrl),
                      
                      // Gradient overlay for better text readability
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: isDark ? Colors.black26 : Colors.white54,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black87),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    park.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.lightOnSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          park.reference,
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        park.state,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.subtext(brightness),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.lightOnSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Latitude',
                          value: park.latitude?.toStringAsFixed(6) ?? 'N/A',
                        ),
                        const Divider(height: 24),
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Longitude',
                          value: park.longitude?.toStringAsFixed(6) ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  ElevatedButton.icon(
                    onPressed: _launchNavigation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.navigation_rounded),
                    label: const Text(
                      'Navigate to Park',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackMap(String url) {
    if (url.isEmpty) {
      return Container(
        color: AppColors.primaryGreen.withOpacity(0.1),
        child: const Icon(Icons.park_rounded, size: 64, color: AppColors.primaryGreen),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.primaryGreen.withOpacity(0.1),
        child: const Icon(Icons.park_rounded, size: 64, color: AppColors.primaryGreen),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryGreen),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: AppColors.subtext(brightness),
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: brightness == Brightness.dark ? Colors.white : AppColors.lightOnSurface,
          ),
        ),
      ],
    );
  }
}
