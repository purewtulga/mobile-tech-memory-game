import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/logic/game_provider.dart';
import 'package:memory_game/models/game_level.dart';

GameProvider makeGame() => GameProvider(
      random: Random(1),
      matchDelay: const Duration(milliseconds: 1),
      mismatchDelay: const Duration(milliseconds: 1),
    );

int partnerOf(GameProvider g, int i) => g.cards.indexWhere(
      (c) => !identical(c, g.cards[i]) && c.pairId == g.cards[i].pairId,
    );

int nonPartnerOf(GameProvider g, int i) =>
    g.cards.indexWhere((c) => c.pairId != g.cards[i].pairId);

void main() {
  late GameProvider game;

  setUp(() => game = makeGame());
  tearDown(() => game.dispose());

  test('түвшин бүрт зөв тооны карт үүснэ, хос бүр яг 2 удаа', () {
    for (final level in GameLevel.values) {
      game.startGame(level);
      expect(game.cards.length, level.totalCards);
      final counts = <int, int>{};
      for (final c in game.cards) {
        counts[c.pairId] = (counts[c.pairId] ?? 0) + 1;
      }
      expect(counts.length, level.pairs);
      expect(counts.values.every((n) => n == 2), isTrue);
    }
  });

  test('адилхан 2 карт: алга болно, алхам 1', () async {
    game.startGame(GameLevel.easy);
    final a = 0;
    final b = partnerOf(game, a);
    await game.onCardTap(a);
    await game.onCardTap(b);
    expect(game.cards[a].isMatched, isTrue);
    expect(game.cards[b].isMatched, isTrue);
    expect(game.moves, 1);
    expect(game.isChecking, isFalse);
  });

  test('өөр 2 карт: буцаж эргэнэ', () async {
    game.startGame(GameLevel.easy);
    final a = 0;
    final b = nonPartnerOf(game, a);
    await game.onCardTap(a);
    await game.onCardTap(b);
    expect(game.cards[a].isFaceUp, isFalse);
    expect(game.cards[b].isFaceUp, isFalse);
    expect(game.cards[a].isMatched, isFalse);
    expect(game.moves, 1);
  });

  test('шалгагдаж байх үед 3 дахь картыг дарахыг хаана', () async {
    game.startGame(GameLevel.easy);
    final a = 0;
    final b = nonPartnerOf(game, a);
    final c = game.cards.indexWhere(
      (x) => x.pairId != game.cards[a].pairId && x.pairId != game.cards[b].pairId,
    );
    await game.onCardTap(a);
    final pending = game.onCardTap(b); // шалгалт эхэлсэн
    await game.onCardTap(c); // үл тооно
    expect(game.cards[c].isFaceUp, isFalse);
    await pending;
    expect(game.moves, 1);
  });

  test('нэг картыг хоёр дарахад алхам нэмэгдэхгүй', () async {
    game.startGame(GameLevel.easy);
    await game.onCardTap(0);
    await game.onCardTap(0);
    expect(game.moves, 0);
  });

  test('бүх хосыг олбол хожно', () async {
    game.startGame(GameLevel.easy);
    for (var pairId = 0; pairId < GameLevel.easy.pairs; pairId++) {
      final idx = <int>[];
      for (var i = 0; i < game.cards.length; i++) {
        if (game.cards[i].pairId == pairId) idx.add(i);
      }
      await game.onCardTap(idx[0]);
      await game.onCardTap(idx[1]);
    }
    expect(game.isWon, isTrue);
    expect(game.moves, GameLevel.easy.pairs);
  });

  test('startGame тоолуур, алхамыг тэглэнэ', () async {
    game.startGame(GameLevel.easy);
    await game.onCardTap(0);
    await game.onCardTap(partnerOf(game, 0));
    game.startGame(GameLevel.medium);
    expect(game.moves, 0);
    expect(game.isWon, isFalse);
    expect(game.cards.every((c) => !c.isFaceUp && !c.isMatched), isTrue);
  });
}
