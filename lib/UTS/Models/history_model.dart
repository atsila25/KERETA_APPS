class TicketHistory {
  final String name;
  final String price;
  final String passengers;
  final String date;
  final String originStation;
  final String destinationStation;
  final String classType;

  TicketHistory({
    required this.name,
    required this.price,
    required this.passengers,
    required this.date,
    required this.originStation,
    required this.destinationStation,
    required this.classType,
  });

  factory TicketHistory.fromJson(Map<String, dynamic> json) {
    return TicketHistory(
      name: json['name'],
      price: json['price'],
      passengers: json['passengers'],
      date: json['date'],
      originStation: json['originStation'],
      destinationStation: json['destinationStation'],
      classType: json['classType'],
    );
  }
}
