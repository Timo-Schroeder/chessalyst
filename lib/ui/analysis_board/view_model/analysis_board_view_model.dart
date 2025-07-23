import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:watch_it/watch_it.dart';

class AnalysisBoardViewModel extends SafeChangeNotifier {
  Position position = Chess.initial;
  Side _orientation = Side.white;
  NormalMove? _promotionMove;
  NormalMove? _lastMove;

  String get fen => position.fen;
  Side get orientation => _orientation;
  PlayerSide get playerSide =>
      (position.turn == Side.white) ? PlayerSide.white : PlayerSide.black;
  Side get sideToMove => position.turn;
  NormalMove? get promotionMove => _promotionMove;
  NormalMove? get lastMove => _lastMove;
  IMap<Square, ISet<Square>> get validMoves => makeLegalMoves(position);

  void flipBoard() {
    _orientation = _orientation.opposite;
    notifyListeners();
  }

  void playMove(NormalMove move, {bool? isDrop}) {
    if (_isPromotionPawnMove(move)) {
      _promotionMove = move;
    } else if (position.isLegal(move)) {
      String san;
      Position tmpPos;
      (tmpPos, san) = position.makeSan(move);
      position = tmpPos;
      _lastMove = move;
      _promotionMove = null;
      _addMove(san);
    }
    notifyListeners();
  }

  void promotionSelection(Role? role) {
    if (role == null) {
      _promotionMove = null;
    } else if (_promotionMove != null) {
      playMove(_promotionMove!.withPromotion(role));
    }
    notifyListeners();
  }

  // https://github.com/lichess-org/flutter-chessground/blob/main/example/lib/main.dart
  bool _isPromotionPawnMove(NormalMove move) {
    return move.promotion == null &&
        position.board.roleAt(move.from) == Role.pawn &&
        ((move.to.rank == Rank.first && position.turn == Side.black) ||
            (move.to.rank == Rank.eighth && position.turn == Side.white));
  }

  void _addMove(String san) {
    PgnChildNode moveNode = PgnChildNode(PgnNodeData(san: san));
    di<PgnGameUseCase>().addMove(moveNode);
  }
}
