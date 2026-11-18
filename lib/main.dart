import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/game_provider.dart';
import 'screens/home_screen.dart';
import 'services/score_service.dart';

void main() {
  runApp(const MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        // Firebase холбохдоо энд FirestoreScoreService()-ээр солино.
        Provider<ScoreService>(create: (_) => InMemoryScoreService()),
      ],
      child: MaterialApp(
        title: 'Memory Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
