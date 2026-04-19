import 'package:isar/isar.dart';

part 'park.g.dart';

@collection
class Park {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String reference; // e.g. TAFF-0001
  
  late String name;
  late String state;
  String? imageUrl;
  
  // For offline search
  @Index(type: IndexType.value)
  List<String> get searchKeywords => [
    reference.toLowerCase(),
    name.toLowerCase(),
    state.toLowerCase(),
  ];
}
