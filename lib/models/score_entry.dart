/// Нэг тоглолтын үр дүн. (Dulguun)
class ScoreEntry {
  const ScoreEntry({
    required this.levelName,
    required this.moves,
    required this.seconds,
    required this.playedAt,
  });

  final String levelName;
  final int moves;
  final int seconds;
  final DateTime playedAt;

  Map<String, dynamic> toMap() => {
        'levelName': levelName,
        'moves': moves,
        'seconds': seconds,
        'playedAt': playedAt.toIso8601String(),
      };

  factory ScoreEntry.fromMap(Map<String, dynamic> map) => ScoreEntry(
        levelName: map['levelName'] as String,
        moves: map['moves'] as int,
        seconds: map['seconds'] as int,
        playedAt: DateTime.parse(map['playedAt'] as String),
      );
}

/// 75 -> "01:15"
String formatSeconds(int totalSeconds) {
  final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
  final s = (totalSeconds % 60).toString().padLeft(2, '0');
  return '$m:$s';
}
