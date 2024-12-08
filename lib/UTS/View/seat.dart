import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<String> availableSeats = List.generate(40, (index) => '${['A', 'B', 'C', 'D'][index % 4]}${(index ~/ 4) + 1}');
  List<String> selectedSeats = []; // Kursi yang dipilih
  int pricePerSeat = 20000; // Harga per kursi
  int totalPrice = 0;

  void toggleSeatSelection(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
      totalPrice = selectedSeats.length * pricePerSeat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: Text('Select Your Seat!'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Your Seat!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10, // 10 baris
                        itemBuilder: (context, rowIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Kolom A dan B (kiri)
                                ...['A', 'B'].map((column) {
                                  String seatId = '$column${rowIndex + 1}';
                                  bool isAvailable = availableSeats.contains(seatId);
                                  bool isSelected = selectedSeats.contains(seatId);

                                  return GestureDetector(
                                    onTap: isAvailable ? () => toggleSeatSelection(seatId) : null,
                                    child: SeatBox(
                                      seatId: seatId,
                                      isAvailable: isAvailable,
                                      isSelected: isSelected,
                                    ),
                                  );
                                }).toList(),
                                // Nomor baris (tengah)
                                Container(
                                  width: 40,
                                  child: Center(
                                    child: Text(
                                      '${rowIndex + 1}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade800,
                                      ),
                                    ),
                                  ),
                                ),
                                // Kolom C dan D (kanan)
                                ...['C', 'D'].map((column) {
                                  String seatId = '$column${rowIndex + 1}';
                                  bool isAvailable = availableSeats.contains(seatId);
                                  bool isSelected = selectedSeats.contains(seatId);

                                  return GestureDetector(
                                    onTap: isAvailable ? () => toggleSeatSelection(seatId) : null,
                                    child: SeatBox(
                                      seatId: seatId,
                                      isAvailable: isAvailable,
                                      isSelected: isSelected,
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LegendItem(
                          color: Colors.white,
                          label: 'Available',
                          borderColor: Colors.blue.shade800,
                        ),
                        LegendItem(
                          color: Colors.orange,
                          label: 'Selected',
                          borderColor: Colors.orange.shade700,
                        ),
                        LegendItem(
                          color: Colors.grey.shade300,
                          label: 'Not Available',
                          borderColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectedSeats.isNotEmpty) // Footer muncul jika kursi dipilih
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp ${totalPrice.toString()}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      Text(
                        'Seat Selected: ${selectedSeats.join(', ')}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ticket_summary', arguments: {
                        'selectedSeats': selectedSeats,
                        'totalPrice': totalPrice,
                      });
                    },
                    child: Text(
                      'Book Now',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SeatBox extends StatelessWidget {
  final String seatId;
  final bool isAvailable;
  final bool isSelected;

  const SeatBox({
    Key? key,
    required this.seatId,
    required this.isAvailable,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.orange
            : isAvailable
                ? Colors.white
                : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.orange.shade700 : Colors.blue.shade800,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          seatId,
          style: TextStyle(
            color: isAvailable ? Colors.blue.shade800 : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final Color borderColor;

  const LegendItem({
    Key? key,
    required this.color,
    required this.label,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: Colors.blue.shade800),
        ),
      ],
    );
  }
}
