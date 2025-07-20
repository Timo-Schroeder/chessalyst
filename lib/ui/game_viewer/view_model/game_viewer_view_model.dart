import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class GameViewerViewModel extends SafeChangeNotifier {
  Position _position = Chess.initial;
  Side _orientation = Side.white;
  NormalMove? _promotionMove;
  NormalMove? _lastMove;

  String get fen => _position.fen;
  Side get orientation => _orientation;
  PlayerSide get playerSide =>
      (_position.turn == Side.white) ? PlayerSide.white : PlayerSide.black;
  Side get sideToMove => _position.turn;
  NormalMove? get promotionMove => _promotionMove;
  NormalMove? get lastMove => _lastMove;
  IMap<Square, ISet<Square>> get validMoves => makeLegalMoves(_position);

  void flipBoard() {
    _orientation = _orientation.opposite;
    notifyListeners();
  }

  void playMove(NormalMove move, {bool? isDrop}) {
    if (_isPromotionPawnMove(move)) {
      _promotionMove = move;
    } else if (_position.isLegal(move)) {
      _position = _position.playUnchecked(move);
      _lastMove = move;
      _promotionMove = null;
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
        _position.board.roleAt(move.from) == Role.pawn &&
        ((move.to.rank == Rank.first && _position.turn == Side.black) ||
            (move.to.rank == Rank.eighth && _position.turn == Side.white));
  }
}
