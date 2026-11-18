/// Нэг картыг төлөөлөх model. (Dulguun)
///
/// Хос карт бүр ижил [pairId]-тай байна.
class MemoryCard {
  MemoryCard({
    required this.pairId,
    required this.symbol,
    this.isFaceUp = false,
    this.isMatched = false,
  });

  /// Хос тус бүрийн ижил дугаар.
  final int pairId;

  /// Картан дээр харагдах emoji.
  final String symbol;

  /// Нээлттэй (урагшаа харсан) эсэх.
  bool isFaceUp;

  /// Хос нь олдож, алга болсон эсэх.
  bool isMatched;
}
