import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Add table_calendar package in pubspec.yaml

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

class MenuButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath), // Placeholder for images
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

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
      body: Padding(
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

class CreateReservationStep2Screen extends StatefulWidget {
  // Receive the previous map (reservationDetails) from Step 1
  final Map<String, String> reservationDetails;

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



class CreateReservationStep3Screen extends StatefulWidget {
  final Map<String, String> reservationDetails;

  const CreateReservationStep3Screen({super.key, required this.reservationDetails});

  @override
  CreateReservationStep3ScreenState createState() => CreateReservationStep3ScreenState();
}

class CreateReservationStep3ScreenState extends State<CreateReservationStep3Screen> {
  DateTime? selectedDate;
  String? selectedTime;
  final List<Map<String, String>> selectedDates = [];

  final List<String> availableTimes = [
    '08:00', '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00'
  ];

  final _formKey = GlobalKey<FormState>();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDate = day;
    });
  }

  void _addSelectedDate() {
    if (selectedDate != null && selectedTime != null) {
      final formattedDate = "${selectedDate!.toLocal()}".split(' ')[0];

      // Check if the selected date and time already exist in the list
      bool duplicate = selectedDates.any((dateTime) =>
      dateTime['date'] == formattedDate && dateTime['time'] == selectedTime);

      if (duplicate) {
        // Show a warning if the date and time are already selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The selected date and time already exist"),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        // Add the new date and time to selectedDates
        selectedDates.add({'date': formattedDate, 'time': selectedTime!});

        // Sort the list based on date and time
        selectedDates.sort((a, b) {
          final dateA = DateTime.parse(a['date']!);
          final dateB = DateTime.parse(b['date']!);

          if (dateA == dateB) {
            final timeA = DateTime.parse('1970-01-01 ${a['time']}');
            final timeB = DateTime.parse('1970-01-01 ${b['time']}');
            return timeA.compareTo(timeB);
          } else {
            return dateA.compareTo(dateB);
          }
        });

        // Reset selected date and time after adding
        setState(() {
          selectedDate = null;
          selectedTime = null;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select both date and time before adding"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select at least one date and time')),
    );
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildUserInfoSection(),
              const SizedBox(height: 16),
              _buildCalendarSection(),
              const SizedBox(height: 16),
              _buildTimeSelection(),
              const SizedBox(height: 16),
              _buildSelectedDatesTable(),
              const SizedBox(height: 32),
              Center (
                child: ElevatedButton(
                  onPressed: _addSelectedDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text("Add Selected Date and Time"),
                ),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDates.isEmpty) {
                      _showError(context);
                    } else {
                      // Update the map with selected dates and times
                      widget.reservationDetails['selectedDates'] = selectedDates.toString();

                      // Print updated map for debugging
                      print(widget.reservationDetails);

                      // Continue to the next page or process the reservation here
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
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/user-default.jpeg'), // Replace with actual image path if needed
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.reservationDetails['meetWith'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(widget.reservationDetails['department'] ?? '', style: const TextStyle(color: Colors.grey)),
            const Text("Head of Strategic Partners", style: TextStyle(color: Colors.grey)), // Example position
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarSection() {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: selectedDate ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      onDaySelected: _onDaySelected,
      calendarFormat: CalendarFormat.month,
    );
  }

  Widget _buildTimeSelection() {
    return Wrap(
      spacing: 8,
      children: availableTimes.map((time) {
        return ChoiceChip(
          label: Text(time),
          selected: selectedTime == time,
          onSelected: (selected) {
            setState(() {
              selectedTime = selected ? time : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSelectedDatesTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Dates and Times',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: selectedDates.map((dateTime) {
              return ListTile(
                title: Text(dateTime['date'] ?? ''),
                subtitle: Text(dateTime['time'] ?? ''),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
