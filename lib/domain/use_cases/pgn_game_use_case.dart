import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class PgnGameUseCase extends SafeChangeNotifier {
  final PgnGame _pgnGame = PgnGame(
    headers: PgnGame.defaultHeaders(),
    moves: PgnNode(),
    comments: List.empty(),
  );

  PgnChildNode? _currentNode;

  PgnGame get pgnGame => _pgnGame;
  PgnChildNode? get currentNode => _currentNode;

  void addMove(PgnChildNode newMove) {
    if (_currentNode == null) {
      _pgnGame.moves.children.add(newMove);
    } else {
      _currentNode!.children.add(newMove);
    }
    _currentNode = newMove;

    notifyListeners();
  }

  void deleteFromMove(PgnChildNode move) {
    PgnNode? parent = _findParentNode(_pgnGame.moves, move);

    if (parent != null) {
      parent.children.remove(move);
      if (parent.isOfExactGenericType(PgnChildNode)) {
        _currentNode = parent as PgnChildNode;
      } else {
        _currentNode = null;
      }
    }

    notifyListeners();
  }

  void promoteMove(PgnChildNode move) {
    PgnNode? parent = _findParentNode(_pgnGame.moves, move);

    if (parent == null) return;

    parent.children.remove(move);
    parent.children.insert(0, move);

    _currentNode = move;

    notifyListeners();
  }

  void goToMove(PgnChildNode move) {
    // set current move
    // update position and lastMove in AnalysisBoard
  }

  PgnNode? _findParentNode(PgnNode root, PgnNode? node) {
    if (root.children.contains(node)) {
      return root;
    }

    for (var child in root.children) {
      var result = _findParentNode(child, node);
      if (result != null) {
        return result;
      }
    }

    return null;
  }
}
