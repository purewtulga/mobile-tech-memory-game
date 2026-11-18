import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_level.dart';
import '../models/score_entry.dart';
import '../services/score_service.dart';

/// Тэргүүлэгчдийн жагсаалт. (Purevtulga)
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  GameLevel _level = GameLevel.medium;
  late Future<List<ScoreEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<ScoreEntry>> _load() =>
      context.read<ScoreService>().topScores(_level.label);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Тэргүүлэгчид')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<GameLevel>(
              segments: [
                for (final l in GameLevel.values)
                  ButtonSegment(value: l, label: Text(l.label)),
              ],
              selected: {_level},
              onSelectionChanged: (s) => setState(() {
                _level = s.first;
                _future = _load();
              }),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ScoreEntry>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final scores = snapshot.data ?? const [];
                if (scores.isEmpty) {
                  return const Center(child: Text('Одоогоор үр дүн алга'));
                }
                return ListView.builder(
                  itemCount: scores.length,
                  itemBuilder: (context, i) {
                    final s = scores[i];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text('${s.moves} алхам'),
                      subtitle: Text(formatSeconds(s.seconds)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
