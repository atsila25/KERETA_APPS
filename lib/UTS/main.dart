import 'package:flutter/material.dart';
import 'package:prakmob3/UTS/View/details_ticket.dart';
import 'package:prakmob3/UTS/View/history_ticket.dart';
import 'package:prakmob3/UTS/View/splash.dart';
import 'package:prakmob3/UTS/View/intercity.dart';
import 'package:prakmob3/UTS/View/local.dart';
import 'package:prakmob3/UTS/View/book_ticket.dart';
import 'package:prakmob3/UTS/View/seat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Ticket Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/intercity': (context) => Intercity(),
        '/local': (context) => Local(),
        '/seat': (context) => SeatSelectionScreen(),
        '/route': (context) => Ticket(pageType: '',),
        // '/tiket': (context) => DetailsTicket(),
        '/history': (context) => HistoryTicket(),
      },
    );
  }
}