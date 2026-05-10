import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/app.dart';
import 'package:gdg_campus_coffee/menu/data/repository/seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  // Upload seed data if collections are empty
  await _initializeSeedData();

  runApp(const App());
}

Future<void> _initializeSeedData() async {
  try {
    await uploadSampleData();
  } catch (e) {
    print("Seed data loading error: $e");
  }
}
