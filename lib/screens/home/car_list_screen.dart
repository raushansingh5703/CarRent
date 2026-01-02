import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/local/pref_service.dart';
import '../auth/login_screen.dart';
import '../booking/booking_history_screen.dart';
import 'car_detail_screen.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  final cars = const [
    {
      'name': 'Honda City',
      'image': 'assets/images/honda_city.png',
      'specs': 'Sedan • 5 Seats',
      'price': 2500
    },
    {
      'name': 'Hyundai Creta',
      'image': 'assets/images/creta.png',
      'specs': 'SUV • 5 Seats',
      'price': 3200
    },
    {
      'name': 'Swift Dzire',
      'image': 'assets/images/dzire.png',
      'specs': 'Hatchback • 5 Seats',
      'price': 2000
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// 🔹 HEADER + LIST
      body: Column(
        children: [
          /// 🔹 FUTURISTIC HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xFF3B82F6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Cars',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () => _showLogout(context),
                )
              ],
            ),
          ),

          /// 🔹 PRODUCT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return _FuturisticCarCard(
                  car: car,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailScreen(car: car),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      /// 🔹 MY BOOKINGS FAB
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.bookmark,color: Colors.white,),
        label: const Text('My Bookings',style: TextStyle(color: Colors.white),),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookingHistoryScreen(),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 LOGOUT DIALOG
  void _showLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: AppColors.textGrey,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        actions: [
          /// CANCEL BUTTON
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textGrey,
              ),
            ),
          ),

          /// LOGOUT BUTTON (PRIMARY)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              await PrefService.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 FUTURISTIC PRODUCT CARD
class _FuturisticCarCard extends StatelessWidget {
  final Map<String, dynamic> car;
  final VoidCallback onTap;

  const _FuturisticCarCard({
    required this.car,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 IMAGE HERO
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.white, // 🔥 background fix
                    child: Image.asset(
                      car['image'],
                      fit: BoxFit.contain, // 🔥 NO STRETCH
                    ),
                  ),


                  /// IMAGE GRADIENT
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  /// PRICE CHIP
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '₹${car['price']} / day',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 DETAILS SECTION
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  /// TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['name'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          car['specs'],
                          style: const TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ARROW
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
