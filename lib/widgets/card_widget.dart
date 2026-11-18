import 'package:flutter/material.dart';

import '../models/memory_card.dart';

/// Нэг карт: арагшаа/урагшаа эргэнэ, таарвал бүдгэрч алга болно. (Purevtulga)
class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.card, required this.onTap});

  final MemoryCard card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final back = Container(
      key: const ValueKey('back'),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.question_mark, color: scheme.onPrimary, size: 32),
    );

    final front = Container(
      key: const ValueKey('front'),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(card.symbol, style: const TextStyle(fontSize: 40)),
        ),
      ),
    );

    // Алга болсон картын байрыг хадгална (grid зөрөхгүй), зөвхөн бүдгэрнэ.
    return AnimatedOpacity(
      opacity: card.isMatched ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: card.isMatched,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: card.isFaceUp ? front : back,
          ),
        ),
      ),
    );
  }
}
