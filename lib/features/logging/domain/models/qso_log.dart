import 'package:isar_community/isar.dart';

part 'qso_log.g.dart';

@collection
class QsoLog {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String callsign;

  @Index()
  late DateTime qsoDate;

  late String timeOn; // HHMMSS format as required by ADIF

  @Index(type: IndexType.hash)
  late String band;

  @Index(type: IndexType.hash)
  late String mode;

  late String stationCallsign;

  late String operatorCallsign;

  late String mySig; // Defaults to 'WWFF'
  
  @Index(type: IndexType.value)
  late String mySigInfo; // e.g. TAFF-0123

  String? sig; // e.g. 'WWFF' for Park-to-Park
  String? sigInfo;

  String? rstSent;
  String? rstRcvd;
  String? comment;
  
  int? txPower;
  String? gridSquare;
}
