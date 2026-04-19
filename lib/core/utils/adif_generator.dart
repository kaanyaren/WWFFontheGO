import 'package:intl/intl.dart';
import '../../features/logging/domain/models/qso_log.dart';

class AdifGenerator {
  static String generate(List<QsoLog> logs) {
    final StringBuffer sb = StringBuffer();
    
    // Header
    sb.writeln('WWFF on the GO Export');
    sb.writeln('Generated on: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}');
    sb.writeln('<ADIF_VER:3>3.1.4');
    sb.writeln('<EOH>');
    sb.writeln();

    for (final log in logs) {
      sb.write(_tag('CALL', log.callsign));
      sb.write(_tag('QSO_DATE', DateFormat('yyyyMMdd').format(log.qsoDate)));
      sb.write(_tag('TIME_ON', log.timeOn));
      sb.write(_tag('BAND', log.band));
      sb.write(_tag('MODE', log.mode));
      sb.write(_tag('RST_SENT', log.rstSent ?? '59'));
      sb.write(_tag('RST_RCVD', log.rstRcvd ?? '59'));
      sb.write(_tag('STATION_CALLSIGN', log.stationCallsign));
      sb.write(_tag('OPERATOR', log.operatorCallsign));
      sb.write(_tag('MY_SIG', log.mySig));
      sb.write(_tag('MY_SIG_INFO', log.mySigInfo));
      
      if (log.sig != null) sb.write(_tag('SIG', log.sig!));
      if (log.sigInfo != null) sb.write(_tag('SIG_INFO', log.sigInfo!));
      if (log.txPower != null) sb.write(_tag('TX_PWR', log.txPower.toString()));
      if (log.comment != null && log.comment!.isNotEmpty) {
        sb.write(_tag('COMMENT', log.comment!));
      }
      
      sb.writeln('<EOR>');
    }

    return sb.toString();
  }

  static String _tag(String name, String value) {
    return '<$name:${value.length}>$value ';
  }
}
