class WwffSpot {
  final String callsign;
  final String wwff;
  final String freq;
  final String mode;
  final DateTime spotTime;
  final String spotter;
  final String? comments;

  WwffSpot({
    required this.callsign,
    required this.wwff,
    required this.freq,
    required this.mode,
    required this.spotTime,
    required this.spotter,
    this.comments,
  });

  factory WwffSpot.fromJson(Map<String, dynamic> json) {
    return WwffSpot(
      callsign: json['callsign'] ?? '',
      wwff: json['wwff'] ?? '',
      freq: json['freq'] ?? '',
      mode: json['mode'] ?? '',
      spotTime: DateTime.tryParse(json['date_time'] ?? '') ?? DateTime.now(),
      spotter: json['spotter'] ?? '',
      comments: json['comments'],
    );
  }
}
