import 'package:flutter/material.dart';
import '87_reception_step2_createreservation.dart';

class CreateReservationScreen extends StatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  CreateReservationScreenState createState() => CreateReservationScreenState();
}

class CreateReservationScreenState extends State<CreateReservationScreen> {
  // Create a Map to store the input values
  final Map<String, String> reservationDetails = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'jobPosition': '',
    'company': '',
    'numberOfGuest': ''
  };

  // Controllers for each TextField to capture the input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController guestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          'Create Reservation',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            buildTextField('Your Name', 'Enter your name', nameController, false),
            const SizedBox(height: 16),
            buildTextField('Email Address', 'Enter your email', emailController, false),
            const SizedBox(height: 16),
            buildTextField('Phone Number', 'e.g. +628123456789', phoneController, true),  // Number input
            const SizedBox(height: 16),
            buildTextField('Job Position', 'Enter job position', jobController, false),
            const SizedBox(height: 16),
            buildTextField('Company', 'Enter company name', companyController, false),
            const SizedBox(height: 16),
            buildTextField('Number of Guest', 'Enter number of guests', guestController, true),  // Number input
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Check for empty inputs
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      jobController.text.isEmpty ||
                      companyController.text.isEmpty ||
                      guestController.text.isEmpty) {
                    // Show an error message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please fill in all fields.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Store the values in the Map and navigate to the next screen
                    setState(() {
                      reservationDetails['name'] = nameController.text;
                      reservationDetails['email'] = emailController.text;
                      reservationDetails['phoneNumber'] = phoneController.text;
                      reservationDetails['jobPosition'] = jobController.text;
                      reservationDetails['company'] = companyController.text;
                      reservationDetails['numberOfGuest'] = guestController.text;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateReservationStep2Screen(reservationDetails: reservationDetails)),
                    );

                    // Debugging print to see the values stored
                    // print(reservationDetails);
                  }
                },
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

  // Reusable TextField builder function
  Widget buildTextField(String label, String placeholder, TextEditingController controller, bool isNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
