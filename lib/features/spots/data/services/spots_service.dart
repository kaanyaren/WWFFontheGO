import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/spot.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final spotsServiceProvider = Provider<SpotsService>((ref) {
  final dio = ref.watch(dioProvider);
  return SpotsService(dio);
});

final spotsProvider = FutureProvider<List<WwffSpot>>((ref) {
  final service = ref.watch(spotsServiceProvider);
  return service.fetchSpots();
});

class SpotsService {
  final Dio dio;

  SpotsService(this.dio);

  Future<List<WwffSpot>> fetchSpots() async {
    try {
      final response = await dio.get('https://wwff.co/static/spots.json');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => WwffSpot.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
