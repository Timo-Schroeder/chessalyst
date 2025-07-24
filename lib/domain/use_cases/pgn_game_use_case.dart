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
  set currentNode(PgnChildNode? node) {
    _currentNode = node;
    notifyListeners();
  }

  String get eventHeader => _pgnGame.headers['Event'] ?? '';
  set eventHeader(String event) {
    _pgnGame.headers['Event'] = event;
    notifyListeners();
  }

  String get siteHeader => _pgnGame.headers['Site'] ?? '';
  set siteHeader(String site) {
    _pgnGame.headers['Site'] = site;
    notifyListeners();
  }

  String get dateHeader => _pgnGame.headers['Date']!;
  set dateHeader(String date) {
    _pgnGame.headers['Date'] = date;
    notifyListeners();
  }

  String get roundHeader => _pgnGame.headers['Round']!;
  set roundHeader(String round) {
    _pgnGame.headers['Round'] = round;
    notifyListeners();
  }

  String get whiteHeader => _pgnGame.headers['White']!;
  set whiteHeader(String white) {
    _pgnGame.headers['White'] = white;
    notifyListeners();
  }

  String get blackHeader => _pgnGame.headers['Black']!;
  set blackHeader(String black) {
    _pgnGame.headers['Black'] = black;
    notifyListeners();
  }

  String get resultHeader => _pgnGame.headers['Result']!;
  set resultHeader(String result) {
    _pgnGame.headers['Result'] = result;
    notifyListeners();
  }

  void addMove(PgnChildNode newMove) {
    if (_currentNode == null) {
      for (var move in _pgnGame.moves.children) {
        if (move.data.san == newMove.data.san) {
          _currentNode = move;
          return;
        }
      }
      _pgnGame.moves.children.add(newMove);
    } else {
      for (var move in _currentNode!.children) {
        if (move.data.san == newMove.data.san) {
          _currentNode = move;
          return;
        }
      }
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

  List<String> getSANlist(PgnChildNode node) {
    return _getSANListTail(_pgnGame.moves, node);
  }

  List<String> _getSANListTail(PgnNode root, PgnChildNode node) {
    if (root.children.contains(node)) {
      return List.of([node.data.san]);
    }

    for (var child in root.children) {
      var sanList = _getSANListTail(child, node);
      if (sanList.isNotEmpty) {
        sanList.insert(0, child.data.san);
        return sanList;
      }
    }

    return List<String>.empty();
  }

  PgnNode? getPreviousMove() {
    return _findParentNode(_pgnGame.moves, _currentNode);
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
