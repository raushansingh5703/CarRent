import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../booking/booking_form_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car;
  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          /// 🔹 HERO IMAGE
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Image.asset(
              car['image'],
              fit: BoxFit.contain,
            ),
          ),

          /// 🔹 IMAGE GRADIENT OVERLAY
          Container(
            height: 340,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          /// 🔹 BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          /// 🔹 CONTENT CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(32)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.fromLTRB(20, 24, 20, 100),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.96),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// NAME + PRICE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            car['name'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color:
                              AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '₹${car['price']} / day',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// SPECS (ICON ROW)
                      Row(
                        children: [
                          _SpecItem(
                              icon: Icons.directions_car,
                              label: car['specs']),
                          const SizedBox(width: 20),
                          const _SpecItem(
                              icon: Icons.event_seat,
                              label: '5 Seats'),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// DESCRIPTION (OPTIONAL FUTURE READY)
                      const Text(
                        'About this car',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Comfortable, fuel-efficient and perfect for city and highway rides.',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      /// 🔹 FIXED BOTTOM BOOK BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, -4),
            )
          ],
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingFormScreen(car: car),
                ),
              );
            },
            child: const Text(
              'Book This Car',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔹 SPEC ITEM WIDGET
class _SpecItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SpecItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
