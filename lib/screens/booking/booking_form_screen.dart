import 'package:flutter/material.dart';

import '../../data/local/db_helper.dart';
import '../../data/local/pref_service.dart';
import '../../core/colors.dart';
import 'booking_confirmation_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  const BookingFormScreen({super.key, required this.car});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController locationCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Book Car'),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 CAR CARD
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE (FIXED)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        color: Colors.white,
                        child: Image.asset(
                          widget.car['image'],
                          fit: BoxFit.contain, // ✅ NO CROP
                          alignment: Alignment.center,
                        ),
                      ),
                    ),

                    /// DETAILS
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.car['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.car['specs'],
                            style: const TextStyle(
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 10),

                          /// PRICE CHIP
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color:
                              AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '₹${widget.car['price']} / day',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// 🔹 PICKUP LOCATION
              const Text(
                'Pickup Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: locationCtrl,
                decoration: InputDecoration(
                  hintText: 'Enter pickup location',
                  prefixIcon:
                  const Icon(Icons.location_on_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pickup location is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Enter a valid location';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              /// 🔹 CONFIRM BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style:
                    TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final user = await PrefService.getUser();

                    await DBHelper.addBooking({
                      'user_email': user,
                      'car_name': widget.car['name'],
                      'car_image': widget.car['image'],
                      'location': locationCtrl.text.trim(),
                      'price': widget.car['price'],
                    });

                    if (!mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const BookingConfirmationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
