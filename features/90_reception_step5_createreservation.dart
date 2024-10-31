import 'dart:io';
import 'package:flutter/material.dart';

class CreateReservationStep5Screen extends StatefulWidget {
  final Map<String, String> reservationDetails;

  const CreateReservationStep5Screen({super.key, required this.reservationDetails});

  @override
  CreateReservationStep5ScreenState createState() => CreateReservationStep5ScreenState();
}

class CreateReservationStep5ScreenState extends State<CreateReservationStep5Screen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _companyController;
  late TextEditingController _numberOfGuestsController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with data from reservationDetails
    _nameController = TextEditingController(text: widget.reservationDetails['name'] ?? '');
    _emailController = TextEditingController(text: widget.reservationDetails['email'] ?? '');
    _phoneController = TextEditingController(text: widget.reservationDetails['phoneNumber'] ?? '');
    _positionController = TextEditingController(text: widget.reservationDetails['jobPosition'] ?? '');
    _companyController = TextEditingController(text: widget.reservationDetails['company'] ?? '');
    _numberOfGuestsController = TextEditingController(text: widget.reservationDetails['numberOfGuest'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _companyController.dispose();
    _numberOfGuestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoPath = widget.reservationDetails['photoPath'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          'Guest Info Detail',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: 'Guest Name', controller: _nameController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email Address', controller: _emailController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Phone Number', controller: _phoneController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Job Position', controller: _positionController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Company', controller: _companyController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Number of Guest', controller: _numberOfGuestsController, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            if (photoPath != null && photoPath.isNotEmpty)
              Center(
                child: Column(
                  children: [
                    Image.file(File(photoPath), height: 200),
                    const SizedBox(height: 8),
                    const Icon(Icons.camera_alt, color: Colors.grey),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: true, // Make the field uneditable
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  void _onNext() {
    // Navigate to the next step or perform additional actions
    // Replace with actual navigation or processing logic as needed
  }
}
