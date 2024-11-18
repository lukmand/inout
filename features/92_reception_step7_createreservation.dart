import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class CreateReservationStep7Screen extends StatefulWidget {
  final Map<String, dynamic> reservationDetails;
  final Map<String, List<Map<String, dynamic>>> roomsByType;

  const CreateReservationStep7Screen({super.key, required this.reservationDetails, required this.roomsByType});

  @override
  CreateReservationStep7ScreenState createState() => CreateReservationStep7ScreenState();
}

class CreateReservationStep7ScreenState extends State<CreateReservationStep7Screen> {
  String? qrCodeId;
  Map<String, List<String>> roomDataByType = {};

  @override
  void initState() {
    super.initState();
    loadRoomData();
  }

  Future<void> loadRoomData() async {
    // List of selected room IDs (make sure it contains integers)
    final selectedRooms = widget.reservationDetails['selectedRooms'].cast<int>();

    // Sample data for roomsByType
    final Map<String, List<Map<String, dynamic>>> roomsData = widget.roomsByType;

    //print(roomsData);
    // Map to hold the room data by type
    Map<String, List<String>> roomType = {};

    // Iterate over each room type in the roomsData map
    roomsData.forEach((roomTypeKey, rooms) {
      //print('Checking rooms in $roomTypeKey');
      for (var room in rooms) {
        if (selectedRooms.contains(room['id'])) {
          //print('Found room: ${room['name']} with ID: ${room['id']}');
          roomType.putIfAbsent(roomTypeKey, () => []).add(room['name']);
        }
      }
    });
    //print(roomType);
    // Update the state with the populated roomsByType data
    setState(() {
      roomDataByType = roomType;
    });

    print(roomDataByType);
  }




  void _generateQRCode() {
    setState(() {
      qrCodeId = DateTime.now().millisecondsSinceEpoch.toString(); // Generate a unique ID for the QR code
      widget.reservationDetails['qrCodeId'] = qrCodeId!; // Store in reservation details
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Guest Info Detail',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReservationDetails(),
              _buildSelectedRooms(),
              const SizedBox(height: 20),
              if (qrCodeId == null)
                Center(
                  child: ElevatedButton(
                    onPressed: _generateQRCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Generate QR Code', style: TextStyle(fontSize: 16)),
                  ),
                )
              else
                _buildQRCodeCard(), // Encased QR Code in a card with header
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying the selected rooms with evenly placed bullet points
  Widget _buildSelectedRooms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: roomDataByType.entries.map((entry) {
        final roomType = entry.key;
        final roomNames = entry.value;

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Type Title
              Text(
                roomType,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Room Names Container styled like a card with bullet points
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Wrap(
                  spacing: 10, // Horizontal spacing between items
                  runSpacing: 4, // Vertical spacing between items
                  children: roomNames.map((name) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 64) / 2, // Ensures two columns
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 8), // Bullet point
                          const SizedBox(width: 5),
                          Expanded(child: Text(name)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQRCodeCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // QR Code Header
        const Text(
          'QR Code',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // QR Code Card
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: GestureDetector(
            onTap: () {
              // Show dialog with zoomed QR
              _showZoomedQRCode(context);
            },
            child: Center(
              child: SizedBox(
                width: 200.0,  // Explicit width for the QR code
                height: 200.0, // Explicit height for the QR code
                child: QrImageView(
                  data: qrCodeId!,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Submit Button
        Center(
          child: SizedBox(
            width: double.infinity, // Make the button span the full width
            child: ElevatedButton(
              onPressed: () {
                // Perform submit action or navigate to the next page
                // Add the qrCodeId to reservationDetails
                if (qrCodeId != null) {
                  widget.reservationDetails['qrCodeId'] = qrCodeId!;
                }

                // Perform submit action or navigate to the next page
                // You can add your submit logic here, e.g., send data to server or navigate
                print("Reservation Details with QR Code: ${widget.reservationDetails}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }

  void _showZoomedQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Zoomed QR Code Image
              Center(
                child: SizedBox(
                  width: 400.0,  // Larger size for the zoomed-in view
                  height: 400.0, // Larger size for the zoomed-in view
                  child: QrImageView(
                    data: qrCodeId!,
                    version: QrVersions.auto,
                    size: 400.0,  // Larger QR size in the dialog
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Close Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Close', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }


  // Single function to handle the reservation details card
  Widget _buildReservationDetails() {
    // Extract selected dates from the reservation details
    List<Map<String, String>> selectedDates = widget.reservationDetails['selectedDates'];

    // Create a formatted string for selected dates
    String formattedDates = selectedDates != null && selectedDates.isNotEmpty
        ? selectedDates.map((dateMap) {
      String dateString = dateMap['date'] ?? '';
      DateTime parsedDate = DateTime.parse(dateString);  // Convert string to DateTime object
      return DateFormat('EEE, MMM dd, yyyy').format(parsedDate);  // Format the date
    }).join('\n')
        : 'No dates available';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Left part: Reservation Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReservationDetailRow(formattedDates),
                const Divider(),
                _buildReservationDetailRow(
                    widget.reservationDetails['name'] ?? 'N/A'),
                const Divider(),
                _buildReservationDetailRow(
                    widget.reservationDetails['jobPosition'] ?? 'N/A'),
                const Divider(),
                _buildReservationDetailRow(
                    widget.reservationDetails['company'] ?? 'N/A'),
                const Divider(),
                _buildReservationDetailRow(
                    widget.reservationDetails['phoneNumber'] ?? 'N/A'),
                const Divider(),
                _buildReservationDetailRow(
                    widget.reservationDetails['numberOfGuest'] ?? 'N/A'),
              ],
            ),
          ),
          // Right part: User Image
          Container(
            padding: const EdgeInsets.all(16.0),
            width: 200,  // Adjust the width for the rectangle
            height: 300,  // Adjust the height for the rectangle
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/user-default.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),  // Optional: rounded corners, remove if no rounding is desired
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for building each reservation detail row
  Widget _buildReservationDetailRow(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
