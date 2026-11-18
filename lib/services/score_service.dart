import '../models/score_entry.dart';

/// Оноо хадгалах/унших интерфейс. (Purevtulga)
///
/// Одоо [InMemoryScoreService] ашиглана (апп хаагдвал арилна).
/// Firebase холбохдоо docs/firebase/ хавтсан дахь жишээгээр
/// FirestoreScoreService бичээд main.dart-д солино. Дэлгэцүүд өөрчлөгдөхгүй.
abstract class ScoreService {
  Future<void> saveScore(ScoreEntry entry);

  /// Түвшин тус бүрийн шилдэг үр дүн (цөөн алхам, дараа нь богино хугацаа).
  Future<List<ScoreEntry>> topScores(String levelName, {int limit = 10});
}

class InMemoryScoreService implements ScoreService {
  final List<ScoreEntry> _scores = [];

  @override
  Future<void> saveScore(ScoreEntry entry) async => _scores.add(entry);

  @override
  Future<List<ScoreEntry>> topScores(String levelName, {int limit = 10}) async {
    final list = _scores.where((s) => s.levelName == levelName).toList()
      ..sort((a, b) {
        final byMoves = a.moves.compareTo(b.moves);
        return byMoves != 0 ? byMoves : a.seconds.compareTo(b.seconds);
      });
    return list.take(limit).toList();
  }
}
