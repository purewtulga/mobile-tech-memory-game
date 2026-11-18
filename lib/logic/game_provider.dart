import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/game_level.dart';
import '../models/memory_card.dart';

/// Memory Game-ийн бүх логик энд. (Dulguun)
///
/// Дүрэм:
///  - Бүх карт арагшаа харсан. Нэг нэгээр нь 2 карт нээнэ.
///  - Адилхан бол 2 карт алга болно (isMatched), өөр бол буцаж эргэнэ.
///  - Бүх карт алга болбол хожно.
///  - 2 карт шалгагдаж байх үед (isChecking) шинэ дарлтыг үл тооно.
class GameProvider extends ChangeNotifier {
  GameProvider({
    Random? random,
    this.matchDelay = const Duration(milliseconds: 500),
    this.mismatchDelay = const Duration(milliseconds: 800),
  }) : _random = random ?? Random();

  /// Хамгийн олон хос (hard = 12) хүрэлцэх emoji.
  static const List<String> symbols = [
    '🐶', '🐱', '🐭', '🐹', '🐰', '🦊',
    '🐻', '🐼', '🐨', '🐯', '🦁', '🐸',
  ];

  final Random _random;
  final Duration matchDelay;
  final Duration mismatchDelay;

  GameLevel _level = GameLevel.medium;
  List<MemoryCard> _cards = [];
  final List<int> _selected = [];
  int _moves = 0;
  int _seconds = 0;
  bool _isChecking = false;
  bool _isWon = false;
  Timer? _timer;
  bool _disposed = false;

  // startGame дуудагдах бүрт нэмэгдэнэ. Хуучин тоглолтын хоцорсон
  // шалгалт шинэ тоглолтыг эвдэхээс сэргийлнэ.
  int _round = 0;

  GameLevel get level => _level;
  UnmodifiableListView<MemoryCard> get cards => UnmodifiableListView(_cards);
  int get moves => _moves;
  int get seconds => _seconds;
  bool get isChecking => _isChecking;
  bool get isWon => _isWon;

  /// Шинэ тоглолт эхлүүлнэ: карт хольж, тоолуурыг тэглэнэ.
  void startGame(GameLevel level) {
    _round++;
    _timer?.cancel();
    _timer = null;

    _level = level;
    _moves = 0;
    _seconds = 0;
    _isChecking = false;
    _isWon = false;
    _selected.clear();

    final chosen = (List<String>.from(symbols)..shuffle(_random))
        .take(level.pairs)
        .toList();

    final cards = <MemoryCard>[];
    for (var pairId = 0; pairId < chosen.length; pairId++) {
      cards.add(MemoryCard(pairId: pairId, symbol: chosen[pairId]));
      cards.add(MemoryCard(pairId: pairId, symbol: chosen[pairId]));
    }
    cards.shuffle(_random);
    _cards = cards;

    _notify();
  }

  /// [index] дугаартай картыг дарахад дуудагдана.
  /// Хоёр дахь карт дээр шалгалт дуустал хүлээж буцна (тест хийхэд тохиромжтой).
  Future<void> onCardTap(int index) async {
    if (_isWon || _isChecking) return; // түгжээ
    if (index < 0 || index >= _cards.length) return;

    final card = _cards[index];
    if (card.isFaceUp || card.isMatched) return;

    _startTimerIfNeeded();
    card.isFaceUp = true;
    _selected.add(index);

    if (_selected.length < 2) {
      _notify();
      return;
    }

    // Хоёр дахь карт: алхам +1, түгжээ тавина.
    _moves++;
    _isChecking = true;
    _notify();

    final first = _cards[_selected[0]];
    final second = _cards[_selected[1]];
    final isMatch = first.pairId == second.pairId;
    final round = _round;

    await Future<void>.delayed(isMatch ? matchDelay : mismatchDelay);
    if (_disposed || round != _round) return;

    if (isMatch) {
      first.isMatched = true;
      second.isMatched = true;
    } else {
      first.isFaceUp = false;
      second.isFaceUp = false;
    }
    _selected.clear();
    _isChecking = false;

    if (_cards.every((c) => c.isMatched)) {
      _isWon = true;
      _timer?.cancel();
      _timer = null;
    }
    _notify();
  }

  void _startTimerIfNeeded() {
    if (_timer != null || _isWon) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;
      _notify();
    });
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
