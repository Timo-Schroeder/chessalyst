import 'package:dartchess/dartchess.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class PgnGameUseCase extends SafeChangeNotifier {
  final PgnGame _pgnGame = PgnGame(
    headers: PgnGame.defaultHeaders(),
    moves: PgnNode(),
    comments: List.empty(),
  );

  PgnGame get pgnGame => _pgnGame;

  void addMove(PgnChildNode? position, PgnChildNode newMove) {
    if (position == null) {
      _pgnGame.moves.children.add(newMove);
    } else {
      position.children.add(newMove);
    }

    notifyListeners();
  }

  void deleteFromMove(PgnChildNode move) {
    PgnNode? parent = _findParentNode(_pgnGame.moves, move);

    if (parent != null) {
      parent.children.remove(move);
    }

    notifyListeners();
  }

  void promoteMove(PgnChildNode move) {
    PgnNode? parent = _findParentNode(_pgnGame.moves, move);

    if (parent == null) return;

    parent.children.remove(move);
    parent.children.insert(0, move);

    notifyListeners();
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
