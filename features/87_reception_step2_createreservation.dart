import 'package:flutter/material.dart';
import '88_reception_step3_createreservation.dart';

class CreateReservationStep2Screen extends StatefulWidget {
  // Receive the previous map (reservationDetails) from Step 1
  final Map<String, dynamic> reservationDetails;

  const CreateReservationStep2Screen({super.key, required this.reservationDetails});

  @override
  CreateReservationStep2ScreenState createState() => CreateReservationStep2ScreenState();
}

class CreateReservationStep2ScreenState extends State<CreateReservationStep2Screen> {
  String? selectedPerson; // Default value for 'Meet With' as null (empty selection)
  String? selectedDepartment; // Default value for 'Department' as null (empty selection)
  final TextEditingController agendaController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Meet With Dropdown
            buildDropdown(
              'Meet With',
              ['Nina Adelia', 'John Doe', 'Alice Smith'],
              selectedPerson, // This is null initially
                  (String? newValue) {
                setState(() {
                  selectedPerson = newValue; // Update the selection
                });
              },
            ),
            const SizedBox(height: 16),
            // Department Dropdown
            buildDropdown(
              'Department',
              ['Sales and Marketing', 'HR', 'Finance'],
              selectedDepartment, // This is null initially
                  (String? newValue) {
                setState(() {
                  selectedDepartment = newValue; // Update the selection
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Agenda',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Agenda Text Field
            TextField(
              controller: agendaController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is your meeting about',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Check for empty inputs
                  if (selectedPerson == null || selectedDepartment == null || agendaController.text.isEmpty) {
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
                    // Update the Map with the new values
                    widget.reservationDetails['meetWith'] = selectedPerson!;
                    widget.reservationDetails['department'] = selectedDepartment!;
                    widget.reservationDetails['agenda'] = agendaController.text;

                    // Print updated map (debugging purpose)
                    // print(widget.reservationDetails);

                    // Handle navigation or submission
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateReservationStep3Screen(reservationDetails: widget.reservationDetails)),
                    );
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

  // Reusable dropdown builder with null (empty) initial selection support
  Widget buildDropdown(String label, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedItem, // This can be null for empty selection
          onChanged: onChanged,
          hint: Text('Select $label'), // Show hint text when no value is selected
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}