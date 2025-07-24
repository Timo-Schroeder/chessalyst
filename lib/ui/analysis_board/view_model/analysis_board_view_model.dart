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
  List<PgnChildNode>? _nextMoveOptions;

  Position get position => _position;
  String get fen => _position.fen;
  Side get orientation => _orientation;
  PlayerSide get playerSide =>
      (_position.turn == Side.white) ? PlayerSide.white : PlayerSide.black;
  Side get sideToMove => _position.turn;
  NormalMove? get promotionMove => _promotionMove;
  NormalMove? get lastMove => _lastMove;
  IMap<Square, ISet<Square>> get validMoves => makeLegalMoves(_position);
  List<PgnChildNode>? get nextMoveOptions => _nextMoveOptions;

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

  void goToFirstMove() {
    _position = Chess.initial;
    _lastMove = null;
    di<PgnGameUseCase>().currentNode = null;
    notifyListeners();
  }

  void goToPreviousMove() {
    var previousMoveNode = di<PgnGameUseCase>().getPreviousMove();

    _goToMove(previousMoveNode);
  }

  void getNextMoveOptions() {
    var nextMoves = di<PgnGameUseCase>().getNextMoves();
    print(nextMoves.length);
    if (nextMoves.isEmpty) return;

    if (nextMoves.length == 1) {
      _goToMove(nextMoves.first);
    }

    _nextMoveOptions = nextMoves;
    notifyListeners();
  }

  void goToNextMove(PgnChildNode nextMove) {
    _nextMoveOptions = null;

    _goToMove(nextMove);
  }

  void goToLastMove() {
    var lastMoveNode = di<PgnGameUseCase>().getLastMove();

    _goToMove(lastMoveNode);
  }

  void _goToMove(PgnNode? moveToGo) {
    PgnNode? move = moveToGo;
    List<String> sanList;

    try {
      sanList = di<PgnGameUseCase>().getSANlist(move as PgnChildNode);
    } catch (e) {
      _position = Chess.initial;
      _lastMove = null;
      di<PgnGameUseCase>().currentNode = null;
      notifyListeners();
      return;
    }

    Position pos = Chess.initial;
    Move? nextMove;
    for (var san in sanList) {
      nextMove = pos.parseSan(san);
      if (nextMove == null) break;
      pos = pos.play(nextMove);
    }

    _position = pos;
    _lastMove = nextMove as NormalMove;
    di<PgnGameUseCase>().currentNode = move;
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
