import 'package:flutter/material.dart';

import 'leaderboard_screen.dart';
import 'level_screen.dart';

/// Нүүр дэлгэц. (Purevtulga)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🧠', style: TextStyle(fontSize: 72)),
                const SizedBox(height: 12),
                Text(
                  'Memory Game',
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Карт эргүүлж хос ол',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 240,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LevelScreen()),
                    ),
                    child: const Text('Тоглох'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 240,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const LeaderboardScreen()),
                    ),
                    child: const Text('Тэргүүлэгчид'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
