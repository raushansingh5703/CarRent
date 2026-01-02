import 'package:flutter/material.dart';
import '../models/car_model.dart';

class CarProvider extends ChangeNotifier {
  final List<CarModel> cars = [
    CarModel(
      id: '1',
      name: 'Honda City',
      specs: 'Sedan • 5 Seats • Manual',
      pricePerDay: 2500,
      available: true,
      image: 'assets/images/honda_city.png',
    ),
    CarModel(
      id: '2',
      name: 'Hyundai Creta',
      specs: 'SUV • 5 Seats • Automatic',
      pricePerDay: 3200,
      available: true,
      image: 'assets/images/creta.png',
    ),
    CarModel(
      id: '3',
      name: 'Swift Dzire',
      specs: 'Hatchback • 5 Seats • Manual',
      pricePerDay: 2000,
      available: false,
      image: 'assets/images/dzire.png',
    ),
  ];

  CarModel getById(String id) {
    return cars.firstWhere((c) => c.id == id);
  }
}
