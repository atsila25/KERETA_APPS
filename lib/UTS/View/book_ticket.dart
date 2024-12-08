import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model untuk data jadwal tiket
class Schedule {
  final String fromStation;
  final String fromTime;
  final String toStation;
  final String toTime;
  final String price;
  final String type; // Type of ticket (e.g., 'Economy', 'Business')

  Schedule({
    required this.fromStation,
    required this.fromTime,
    required this.toStation,
    required this.toTime,
    required this.price,
    required this.type,  // New field for ticket type
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      fromStation: json['from_station'],
      fromTime: json['from_time'],
      toStation: json['to_station'],
      toTime: json['to_time'],
      price: json['price'],
      type: json['type'] ?? 'Economy', // Default to 'Economy' if no type
    );
  }
}

// Fungsi untuk mengambil jadwal tiket dari API
Future<List<Schedule>> fetchSchedules() async {
  final response = await http.get(Uri.parse('https://example.com/api/schedules'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Schedule.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load schedules');
  }
}

class Ticket extends StatelessWidget {
  final String pageType;

  Ticket({required this.pageType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00226B),
        title: Text(
          pageType == 'local' ? 'Local Tickets' : 'Intercity Tickets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',  // Sesuaikan font jika diperlukan
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigasi kembali ke halaman sebelumnya berdasarkan halaman yang dipilih
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Schedule>>(
        future: fetchSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No schedules available.'));
          } else {
            List<Schedule> schedules = snapshot.data!;

            return Column(
              children: [
                Container(
                  width: 375,
                  height: 812,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFE0F0FF), Color(0xFF00226B)],  // Warna latar belakang sesuai gambar
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 110, // Penyesuaian posisi sesuai gambar
                        child: Container(
                          width: 330,
                          height: 180,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header untuk jenis tiket
                              Text(
                                schedules.isNotEmpty
                                    ? schedules[0].type  // Ambil jenis tiket dari API
                                    : 'Economy', // Default jika API belum berhasil
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6696FF),
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Menampilkan jadwal tiket (contoh untuk tiket pertama dari API)
                              for (var schedule in schedules) ...[
                                // Menampilkan data jadwal dari API
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Bagian dari stasiun dan waktu keberangkatan
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            schedule.fromStation,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF3374FF),
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            schedule.fromTime,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF6696FF),
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 12),
                                      // Divider untuk memisahkan stasiun asal dan tujuan
                                      Container(
                                        width: 60,
                                        height: 1,
                                        color: Color(0xFF3374FF),
                                      ),
                                      const SizedBox(width: 12),
                                      // Bagian tujuan dan waktu tiba
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            schedule.toStation,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF3374FF),
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            schedule.toTime,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF6696FF),
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Harga tiket
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Available',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00226B),
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      Text(
                                        schedule.price,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF8900),
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        '/pax',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFA5A7AD),
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
