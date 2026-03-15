import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependancy_injection.dart';
import 'core/utils/custom_bloc_observer.dart';
import 'features/chat/ui/screens/chat_screen.dart';

void main() {
  setupGetIt();
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)),
      ),
      home: const ChatScreenWidget(),
    );
  }
}
