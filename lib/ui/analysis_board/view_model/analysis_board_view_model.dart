import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:watch_it/watch_it.dart';

class AnalysisBoardViewModel extends SafeChangeNotifier {
  Position _position = Chess.initial;
  Side _orientation = Side.white;
  NormalMove? _promotionMove;
  NormalMove? _lastMove;

  Position get position => _position;
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
      String san;
      Position tmpPos;
      (tmpPos, san) = _position.makeSan(move);
      _position = tmpPos;
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

  void goToPreviousMove() {
    var previousMoveNode = di<PgnGameUseCase>().getPreviousMove();
    List<String> sanList;

    // If type casting fails, we are at the root of the game. Just reset everything.
    try {
      sanList = di<PgnGameUseCase>().getSANlist(
        previousMoveNode as PgnChildNode,
      );
    } catch (e) {
      _position = Chess.initial;
      _lastMove = null;
      di<PgnGameUseCase>().currentNode = null;
      notifyListeners();
      return;
    }

    Position pos = Chess.initial;
    Move? move;
    for (var san in sanList) {
      move = pos.parseSan(san);
      if (move == null) break;
      pos = pos.play(move);
    }

    _position = pos;
    _lastMove = move as NormalMove;
    di<PgnGameUseCase>().currentNode = previousMoveNode;
    notifyListeners();
  }

  // https://github.com/lichess-org/flutter-chessground/blob/main/example/lib/main.dart
  bool _isPromotionPawnMove(NormalMove move) {
    return move.promotion == null &&
        _position.board.roleAt(move.from) == Role.pawn &&
        ((move.to.rank == Rank.first && _position.turn == Side.black) ||
            (move.to.rank == Rank.eighth && _position.turn == Side.white));
  }

  void _addMove(String san) {
    PgnChildNode moveNode = PgnChildNode(PgnNodeData(san: san));
    di<PgnGameUseCase>().addMove(moveNode);
  }
}
