import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Add table_calendar package in pubspec.yaml

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