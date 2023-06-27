import 'package:calculator/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/calculator_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

Size? deviceSize;

// TODO: implement portable lock
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        Provider<HistoryProvider>(
          create: (_) => HistoryProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
