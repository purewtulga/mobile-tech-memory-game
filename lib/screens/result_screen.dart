import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/game_provider.dart';
import '../models/score_entry.dart';
import 'game_screen.dart';

/// Хожсон дэлгэц. (Purevtulga)
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 72)),
                const SizedBox(height: 12),
                Text('Та хожлоо!', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 24),
                Text('Түвшин: ${game.level.label}'),
                Text('Хугацаа: ${formatSeconds(game.seconds)}'),
                Text('Алхам: ${game.moves}'),
                const SizedBox(height: 32),
                SizedBox(
                  width: 240,
                  child: FilledButton(
                    onPressed: () {
                      game.startGame(game.level);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GameScreen()),
                      );
                    },
                    child: const Text('Дахин тоглох'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 240,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).popUntil((r) => r.isFirst),
                    child: const Text('Нүүр хуудас'),
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
