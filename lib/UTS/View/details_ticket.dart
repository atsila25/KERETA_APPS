import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: _loadSharedPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading preferences"));
            } else {
              return ListView(
                children: [
                  DetailsTicket(snapshot.data!),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, String>> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load data from SharedPreferences or use default values if not set
    return {
      'name': prefs.getString('name') ?? 'Default Passenger',
      'bookingCode': prefs.getString('bookingCode') ?? 'XYZ123',
      'departure': prefs.getString('departure') ?? 'St Asal 15:00',
      'arrival': prefs.getString('arrival') ?? 'St Tujuan 18:00',
      'seatNumber': prefs.getString('seatNumber') ?? 'A1',
    };
  }
}

class DetailsTicket extends StatelessWidget {
  final Map<String, String> ticketData;

  DetailsTicket(this.ticketData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // Adjust width dynamically
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF99B9FF), Color(0xFF00226B)],
            ),
          ),
          child: Stack(
            children: [
              // Title and Header
              Positioned(
                left: 0,
                top: 28,
                child: Container(
                  width: 375,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/local');
                        },
                      ),
                      const SizedBox(width: 42),
                      Text(
                        'Your Boarding Pass',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                          height: 0.06,
                          letterSpacing: -0.48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Main Body with Ticket Information
              Positioned(
                left: 38,
                top: 128,
                child: Container(
                  height: 371,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/50x50"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Book Trail',
                            style: TextStyle(
                              color: Color(0xFF00226B),
                              fontSize: 24,
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                              letterSpacing: -0.48,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailCard('Name:', ticketData['name']!),
                          _buildDetailCard(
                              'Booking Code:', ticketData['bookingCode']!),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailCard(
                              'Departure:', ticketData['departure']!),
                          _buildDetailCard('Arrival:', ticketData['arrival']!),
                        ],
                      ),
                      const SizedBox(height: 32),
                      _buildDetailCard(
                          'Seat Number:', ticketData['seatNumber']!),
                    ],
                  ),
                ),
              ),
              // Book Ticket Button
              Positioned(
                left: 38,
                top: 531,
                child: Container(
                  width: 304,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Ticket',
                        style: TextStyle(
                          color: Color(0xFF3374FF),
                          fontSize: 20,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for details card
  Widget _buildDetailCard(String label, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF99B9FF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF3374FF),
              fontSize: 16,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF003099),
              fontSize: 20,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
