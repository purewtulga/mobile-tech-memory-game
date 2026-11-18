import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/game_provider.dart';
import '../models/game_level.dart';
import 'game_screen.dart';

/// Түвшин сонгох дэлгэц. (Purevtulga)
class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Түвшин сонгох')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final level in GameLevel.values)
            Card(
              child: ListTile(
                title: Text(level.label),
                subtitle: Text(
                    '${level.rows} x ${level.cols} • ${level.pairs} хос'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.read<GameProvider>().startGame(level);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GameScreen()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
