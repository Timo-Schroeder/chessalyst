enum GameResult {
  draw('1/2-1/2'),
  white('1-0'),
  black('0-1'),
  ongoing('*');

  const GameResult(this.name);

  final String name;
}
