import 'package:flutter/material.dart';
import 'features/73_home_reception.dart';
import 'features/74_reception_reservation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/reservationList': (context) => const ReservationListScreen(), // Add the route for the Reservation List
      },
    );
  }
}









