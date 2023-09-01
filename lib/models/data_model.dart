class CandlestickData {
  final double open;
  final double high;
  final double low;
  final double close;
  final DateTime timestamp;

  CandlestickData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.timestamp,
  });

  factory CandlestickData.fromJson(Map<String, dynamic> json) {
    return CandlestickData(
      open: json['open'] ?? 0.0,
      high: json['high'] ?? 0.0,
      low: json['low'] ?? 0.0,
      close: json['close'] ?? 0.0,
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toString()),
    );
  }
}
