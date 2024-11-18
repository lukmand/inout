import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '92_reception_step7_createreservation.dart';

class CreateReservationStep6Screen extends StatefulWidget {
  final Map<String, dynamic> reservationDetails;

  const CreateReservationStep6Screen({super.key, required this.reservationDetails});

  @override
  CreateReservationStep6ScreenState createState() => CreateReservationStep6ScreenState();
}

class CreateReservationStep6ScreenState extends State<CreateReservationStep6Screen> {
  Map<String, List<Map<String, dynamic>>> roomsByType = {};
  List<int> selectedRooms = [];

  @override
  void initState() {
    super.initState();
    _loadRoomData();
  }

  Future<void> _loadRoomData() async {
    final url = Uri.parse('http://127.0.0.1:5000/room/?order=asc&sort_by=room_id&limit=100&page=1'); // Replace with your API endpoint

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Parse JSON response
        final Map<String, List<Map<String, dynamic>>> parsedRooms = {};
        for (var room in data) {
          final roomType = room['room_type_description']; // Room type name
          final roomId = room['room_id'];                 // Room ID
          final roomName = room['description'];           // Room name

          // Construct room entry
          final roomEntry = {
            'id': roomId,
            'name': roomName,
          };

          // Add room to the appropriate room type
          parsedRooms.putIfAbsent(roomType, () => []).add(roomEntry);
        }

        setState(() {
          roomsByType = parsedRooms; // Update state with parsed data
        });
      } else {
        print('Failed to load rooms data');
      }
    } catch (error) {
      print('Error fetching room data: $error');
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
          'Guest Access',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: roomsByType.keys.map((roomType) => buildRoomSection(roomType)).toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text('Next', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget buildRoomSection(String roomType) {
    final roomList = roomsByType[roomType]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          roomType,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: roomList.map((room) {
            final roomId = room['id'] as int;
            final roomName = room['name'] as String;
            return FilterChip(
              label: Text(roomName),
              selected: selectedRooms.contains(roomId),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedRooms.add(roomId);
                  } else {
                    selectedRooms.remove(roomId);
                  }
                });
              },
              selectedColor: Colors.blue.withOpacity(0.2),
              checkmarkColor: Colors.blue,
            );
          }).toList(),
        ),
        const Divider(height: 32),
      ],
    );
  }

  void _onNext() {
    widget.reservationDetails['selectedRooms'] = selectedRooms;
    print(widget.reservationDetails);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateReservationStep7Screen(
          reservationDetails: widget.reservationDetails,
          roomsByType: roomsByType,
        ),
      ),
    );
  }
}
