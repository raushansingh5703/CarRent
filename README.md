# 🚗 CarRent – Car Rental Booking App (Flutter)

A clean, modern **Car Rental Booking App (MVP)** built using **Flutter** as part of a technical assignment.  
The app focuses on **local authentication, booking flow, and persistent storage** — without using any backend.

---

## 📱 App Overview

- **App Name:** CarRent 
- **Platform:** Flutter (Android / iOS)  
- **Type:** MVP / Assignment Project  
- **Backend:** ❌ None (Local Storage Only)

---

## ✨ Features

### 🔐 Authentication
- Splash screen with auto-login
- Login using email & password
- Signup with name, email & password
- Session managed using **SharedPreferences**
- Logout with confirmation dialog

### 🚘 Car Browsing
- Static car list (mock data)
- Car detail screen with image, specs & price
- Smooth navigation between screens

### 📝 Booking Flow
- Booking form with input validation
- Pickup location entry
- Booking confirmation screen

### 📦 Booking Management
- Bookings stored using **SQLite**
- Multiple users supported
- Each user sees **only their own bookings**
- Booking history list
- Booking detail screen showing:
  - Car image & details
  - Pickup location
  - Price
  - Logged-in user name & email

### 🎨 UI / UX
- Consistent color theme across all screens
- Modern cards & rounded UI
- Gradient headers
- Proper image fitting (no crop/stretch issues)

---

## 🛠 Tech Stack

- **Flutter**
- **Dart**
- **SQLite (sqflite)**
- **SharedPreferences**
- Material UI

---

## 📂 Folder Structure

    lib/
    ├── core/
    │ └── colors.dart
    │
    ├── data/
    │ └── local/
    │ ├── db_helper.dart
    │ └── pref_service.dart
    │
    ├── screens/
    │ ├── splash/
    │ │ └── splash_screen.dart
    │ │
    │ ├── auth/
    │ │ ├── login_screen.dart
    │ │ └── signup_screen.dart
    │ │
    │ ├── home/
    │ │ ├── car_list_screen.dart
    │ │ └── car_detail_screen.dart
    │ │
    │ ├── booking/
    │ │ ├── booking_form_screen.dart
    │ │ ├── booking_confirmation_screen.dart
    │ │ ├── booking_history_screen.dart
    │ │ └── booking_detail_screen.dart
    │
    └── main.dart


---


---

## ▶️ How to Run the Project

1. Clone the repository:
   ```bash
   git clone <your-github-repo-url>

2. Install dependencies:
    ```bash
    flutter pub get

3. Run the app:
    ```bash
    flutter pub get

## 🧪 Notes for Reviewer

    No backend is used; all data is stored locally.
    SQLite is used for users & bookings.
    SharedPreferences is used for session management.
    This project focuses on clean code, UI consistency, and logic clarity.

## ✅ Assignment Requirements Covered

    ✔ Multi-screen Flutter app
    ✔ Local authentication (mock)
    ✔ Static product (car) listing
    ✔ Booking form & confirmation
    ✔ Persistent booking history
    ✔ Clean folder structure
    ✔ Visually presentable UI    
## 👨‍💻 Developer

    Raushan Kumar Singh
    Flutter Developer
