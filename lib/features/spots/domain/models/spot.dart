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

  String get band {
    try {
      final f = double.parse(freq);
      if (f >= 1.8 && f <= 2.0) return '160m';
      if (f >= 3.5 && f <= 4.0) return '80m';
      if (f >= 5.3 && f <= 5.4) return '60m';
      if (f >= 7.0 && f <= 7.3) return '40m';
      if (f >= 10.1 && f <= 10.15) return '30m';
      if (f >= 14.0 && f <= 14.35) return '20m';
      if (f >= 18.068 && f <= 18.168) return '17m';
      if (f >= 21.0 && f <= 21.45) return '15m';
      if (f >= 24.89 && f <= 24.99) return '12m';
      if (f >= 28.0 && f <= 29.7) return '10m';
      if (f >= 50.0 && f <= 54.0) return '6m';
      if (f >= 144.0 && f <= 148.0) return '2m';
      if (f >= 430.0 && f <= 440.0) return '70cm';
    } catch (_) {}
    return '';
  }
}
