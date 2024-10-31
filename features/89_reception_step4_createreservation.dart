import 'dart:io';
import 'package:flutter/material.dart';
import '90_reception_step5_createreservation.dart';

class CreateReservationStep4Screen extends StatefulWidget {
  final Map<String, String> reservationDetails;

  const CreateReservationStep4Screen({super.key, required this.reservationDetails});

  @override
  CreateReservationStep4ScreenState createState() => CreateReservationStep4ScreenState();
}

class CreateReservationStep4ScreenState extends State<CreateReservationStep4Screen> {
  File? _imageFile;

  // Placeholder function for photo capture
  Future<void> _takePhoto() async {
    // Simulate capturing an image by setting a placeholder path
    const placeholderPath = 'assets/user-default.jpeg';

    setState(() {
      _imageFile = File(placeholderPath);
      // Update reservation details with the placeholder image path
      widget.reservationDetails['photoPath'] = placeholderPath;
    });

    // Only navigate if the widget is still in the tree
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateReservationStep5Screen(
            reservationDetails: widget.reservationDetails,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          'Take Photo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 300)
                : Image.asset('assets/user-default.jpeg', height: 300),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Photo"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
