import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
            child: Row(
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
              ],
            ),
        ),
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MenuButton(
                  imagePath: 'assets/reception-removebg-preview.png', // Replace with actual image path
                  title: 'Reception',
                  onPressed: () {
                    Navigator.pushNamed(context, '/reservationList'); // Navigate to the reservation list on click
                  },
                ),
                MenuButton(
                  imagePath: 'assets/visitor-removebg-preview.png', // Replace with actual image path
                  title: 'Visitor',
                  onPressed: () {}, // This can be const because it does nothing
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MenuButton(
                  imagePath: 'assets/room_management-removebg-preview.png', // Replace with actual image path
                  title: 'Room Management',
                  onPressed: () {}, // This can be const because it does nothing
                ),
                MenuButton(
                  imagePath: 'assets/calendar-removebg-preview.png', // Replace with actual image path
                  title: 'Calendar',
                  onPressed: () {}, // This can be const because it does nothing
                ),
              ],
            ),
            MenuButton(
              imagePath: 'assets/setting-removebg-preview.png', // Replace with actual image path
              title: 'Setting',
              onPressed: () {}, // This can be const because it does nothing
            ),
          ],
        ),
      ),
    );
  }
}