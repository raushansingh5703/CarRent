import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../data/local/db_helper.dart';
import '../../data/local/pref_service.dart';
import 'booking_detail_screen.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 GRADIENT BACKGROUND (SAME AS LOGIN / SIGNUP)
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'My Bookings',
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: FutureBuilder<String?>(
                      future: PrefService.getUser(),
                      builder: (context, userSnap) {
                        if (!userSnap.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final userEmail = userSnap.data!;
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: DBHelper.getBookings(userEmail),
                          builder: (context, bookingSnap) {
                            if (bookingSnap.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!bookingSnap.hasData ||
                                bookingSnap.data!.isEmpty) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.car_rental,
                                        size: 48,
                                        color: Colors.grey),
                                    SizedBox(height: 12),
                                    Text(
                                      'No bookings found',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                        AppColors.textGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final bookings = bookingSnap.data!;

                            return ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: bookings.length,
                              itemBuilder: (context, index) {
                                final booking = bookings[index];
                                print("booking $booking");
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            BookingDetailScreen(
                                                booking:
                                                booking),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.08),
                                          blurRadius: 16,
                                          offset:
                                          const Offset(0, 8),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        /// 🔹 IMAGE
                                        ClipRRect(
                                          borderRadius:
                                          const BorderRadius
                                              .horizontal(
                                            left: Radius.circular(
                                                16),
                                          ),
                                          child: Container(
                                            width: 110,
                                            height: 100,
                                            padding:
                                            const EdgeInsets
                                                .all(8),
                                            color: Colors.white,
                                            child: Image.asset(
                                              booking[
                                              'car_image'],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),

                                        /// 🔹 DETAILS
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(14),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  booking[
                                                  'car_name'],
                                                  style:
                                                  const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color: AppColors
                                                        .textDark,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: 6),
                                                Text(
                                                  'Pickup: ${booking['location']}',
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style:
                                                  const TextStyle(
                                                    color: AppColors
                                                        .textGrey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: 10),

                                                /// PRICE CHIP
                                                Container(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                    vertical: 5,
                                                  ),
                                                  decoration:
                                                  BoxDecoration(
                                                    color: AppColors
                                                        .primary
                                                        .withOpacity(
                                                        0.12),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20),
                                                  ),
                                                  child: Text(
                                                    '₹${booking['price']}',
                                                    style:
                                                    const TextStyle(
                                                      color: AppColors
                                                          .primary,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
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
