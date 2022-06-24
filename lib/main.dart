import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/App.dart';

import 'constants/session_manager.dart';

final sessionManager = SessionManager();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sessionManager.initializeSession();
  runApp(const App());
}
