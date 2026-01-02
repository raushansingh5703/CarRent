import 'package:flutter/material.dart';

import '../home/car_list_screen.dart';


class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle,
                size: 60, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Booking Confirmed!',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => const CarListScreen()),
                    (route) => false,
              ),
              child: const Text('Go to Home'),
            )
          ],
        ),
      ),
    );
  }
}
