import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/providers/settings_provider.dart';

import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyA_xAYo_5peVlcmA76RYRHASuBY8v4V8pc',
      appId: 'com.example.todo_app',
      messagingSenderId: '281542958402',
      projectId: 'new-todo-app-a00b1',
    ),
  );
  await FirebaseFirestore.instance.enableNetwork();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}
