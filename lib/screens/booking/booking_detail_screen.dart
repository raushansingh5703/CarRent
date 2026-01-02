import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../data/local/db_helper.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> booking;
  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 GRADIENT BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  Color(0xFF60A5FA),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// 🔹 TOP BAR
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔹 WHITE CONTENT AREA
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 CAR IMAGE
                          Container(
                            height: 220,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  Colors.black.withOpacity(0.08),
                                  blurRadius: 18,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              booking['car_image'],
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// 🔹 CAR NAME
                          Text(
                            booking['car_name'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// 🔹 USER DETAILS (FIXED HERE)
                          _InfoRowFuture(
                            label: 'Booked By',
                            email: booking['user_email'],
                          ),
                          const SizedBox(height: 8),
                          _InfoRow(
                            label: 'Email',
                            value: booking['user_email'],
                          ),

                          const SizedBox(height: 16),

                          /// 🔹 BOOKING DETAILS
                          _InfoRow(
                            label: 'Pickup Location',
                            value: booking['location'],
                          ),
                          const SizedBox(height: 12),
                          _InfoRow(
                            label: 'Price',
                            value: '₹${booking['price']} / day',
                            highlight: true,
                          ),

                          const SizedBox(height: 30),

                          /// 🔹 STATUS
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Booking Confirmed',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 NORMAL INFO ROW
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight:
              highlight ? FontWeight.bold : FontWeight.w500,
              color: highlight
                  ? AppColors.primary
                  : AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}

/// 🔹 USER NAME FETCH ROW (FIX)
class _InfoRowFuture extends StatelessWidget {
  final String label;
  final String email;

  const _InfoRowFuture({
    required this.label,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DBHelper.getUserName(email),
      builder: (context, snapshot) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                snapshot.data ?? 'Loading...',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
