import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/game_provider.dart';
import '../models/score_entry.dart';
import '../services/score_service.dart';
import '../widgets/card_widget.dart';
import 'result_screen.dart';

/// Тоглоомын дэлгэц. (Purevtulga)
/// Тоглолтыг LevelScreen дээр startGame-ээр эхлүүлсэн байх ёстой.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameProvider _game;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _game = context.read<GameProvider>();
    _game.addListener(_onGameChanged);
  }

  @override
  void dispose() {
    _game.removeListener(_onGameChanged);
    super.dispose();
  }

  void _onGameChanged() {
    if (_finished || !_game.isWon) return;
    _finished = true;

    context.read<ScoreService>().saveScore(
          ScoreEntry(
            levelName: _game.level.label,
            moves: _game.moves,
            seconds: _game.seconds,
            playedAt: DateTime.now(),
          ),
        );

    // Сүүлийн картын алга болох animation харагдахын тулд бага зэрэг хүлээнэ.
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ResultScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_game.level.label)),
      body: Consumer<GameProvider>(
        builder: (context, game, _) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Stat(icon: Icons.timer, text: formatSeconds(game.seconds)),
                    _Stat(icon: Icons.touch_app, text: '${game.moves} алхам'),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: game.level.cols,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: game.cards.length,
                    itemBuilder: (context, i) => CardWidget(
                      card: game.cards[i],
                      onTap: () => game.onCardTap(i),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 6),
        Text(text, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
