class Schedule {
  final String fromStation;
  final String fromTime;
  final String toStation;
  final String toTime;
  final String price;

  Schedule({
    required this.fromStation,
    required this.fromTime,
    required this.toStation,
    required this.toTime,
    required this.price,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      fromStation: json['from_station'],
      fromTime: json['from_time'],
      toStation: json['to_station'],
      toTime: json['to_time'],
      price: json['price'],
    );
  }
}
