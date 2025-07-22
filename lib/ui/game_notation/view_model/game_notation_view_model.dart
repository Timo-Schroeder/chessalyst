import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:dartchess/dartchess.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:watch_it/watch_it.dart';

class GameNotationViewModel extends SafeChangeNotifier {
  final List<PgnNodeData> _mainLine = di<PgnGameUseCase>().pgnGame.moves
      .mainline()
      .toList();
  PgnChildNode? _currentMove;

  List<PgnNodeData> get mainLine => _mainLine;
  PgnChildNode? get currentMove => _currentMove;
}
