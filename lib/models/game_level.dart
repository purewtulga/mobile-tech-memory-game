/// Тоглоомын түвшин. (Dulguun)
///
/// rows x cols нь картын тор. Нийт карт үргэлж тэгш тоо байна.
enum GameLevel {
  easy('Хялбар', 4, 3), // 12 карт, 6 хос
  medium('Дунд', 4, 4), // 16 карт, 8 хос
  hard('Хэцүү', 6, 4); // 24 карт, 12 хос

  const GameLevel(this.label, this.rows, this.cols);

  final String label;
  final int rows;
  final int cols;

  int get totalCards => rows * cols;
  int get pairs => totalCards ~/ 2;
}
