import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class GameNotation extends StatelessWidget with WatchItMixin {
  const GameNotation({super.key});

  @override
  Widget build(BuildContext context) {
    final pgnGameUseCase = watchIt<PgnGameUseCase>();
    final pgnString = pgnGameUseCase.pgnGame.makePgn();

    return YaruSection(
      padding: EdgeInsetsGeometry.all(16),
      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Text(pgnString)],
      ),
    );
  }
}
