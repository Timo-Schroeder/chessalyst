import 'dart:convert';

import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:chessalyst/ui/analysis_board/view_model/analysis_board_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:watch_it/watch_it.dart';

class GameViewerViewModel extends SafeChangeNotifier {
  bool _addCommentBefore = false;
  String _comment = '';

  bool get addCommentBefore => _addCommentBefore;
  set addCommentBefore(bool addBefore) {
    _addCommentBefore = addBefore;
    notifyListeners();
  }

  String get comment => _comment;
  set comment(String comment) {
    _comment = comment;
    notifyListeners();
  }

  void saveComment() {
    final currentMove = di<PgnGameUseCase>().currentNode;
    if (currentMove == null) return;

    var data = currentMove.data;
    if (_addCommentBefore) {
      data.startingComments = List.of([_comment]);
    } else {
      data.comments = List.of([_comment]);
    }

    _addCommentBefore = false;
    _comment = '';

    notifyListeners();
  }

  void saveFile() async {
    String game = di<PgnGameUseCase>().pgnGame.makePgn();
    Uint8List bytes = Uint8List.fromList(utf8.encode(game));

    FilePicker.platform.saveFile(
      dialogTitle: "Save Game",
      fileName: 'game.pgn',
      allowedExtensions: List.of(['pgn']),
      bytes: bytes,
    );
  }

  void deleteMove() {
    var currentMove = di<PgnGameUseCase>().currentNode;

    di<AnalysisBoardViewModel>().goToPreviousMove();
    di<PgnGameUseCase>().deleteFromMove(currentMove);
  }

  void promoteLine() {
    var currentMove = di<PgnGameUseCase>().currentNode;
    if (currentMove == null) return;

    di<PgnGameUseCase>().promoteMove(currentMove);
  }
}
