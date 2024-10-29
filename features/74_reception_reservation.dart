import 'package:flutter/material.dart';
import '86_reception_step1_createreservation.dart';

// Reservation List Screen UI
class ReservationListScreen extends StatelessWidget {
  const ReservationListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 40,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/inout-removebg-preview.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Reservation List',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ),
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateReservationScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Type your search here ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // List of reservations
            Expanded(
              child: ListView(
                children: [
                  buildReservationCard('Thu, Mar 07, 2024', 'Rudi Tjahyadi', 'Nina Adelina', '15:00'),
                  buildReservationCard('Thu, Mar 07, 2024', 'Bella Kartika', 'Tamara Sumargo', '10:00'),
                  buildReservationCard('Thu, Mar 07, 2024', 'Suwarno Hadi', 'Citra Lestari', '13:00'),
                  buildReservationCard('Thu, Mar 07, 2024', 'Hartono Idur', 'Dodi Hendrawan', '09:00'),
                  buildReservationCard('Thu, Mar 07, 2024', 'Rudi Tjahyadi', 'Nina Adelina', '15:00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for each reservation card
  Widget buildReservationCard(String date, String guestName, String meetWith, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(date),
            const SizedBox(height: 8),
            const Text('Guest Name', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(guestName),
            const SizedBox(height: 8),
            const Text('Meet With', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(meetWith),
            const SizedBox(height: 8),
            const Text('Reserved Time', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(time),
          ],
        ),
      ),
    );
  }
}