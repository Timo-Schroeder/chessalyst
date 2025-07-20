import 'package:chessalyst/ui/game_viewer/view_model/game_viewer_view_model.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class AnalysisBoard extends StatelessWidget with WatchItMixin {
  const AnalysisBoard({super.key});

  @override
  Widget build(BuildContext context) {
    Side orientation = watchPropertyValue(
      (GameViewerViewModel vm) => vm.orientation,
    );
    String fen = watchPropertyValue((GameViewerViewModel vm) => vm.fen);
    PlayerSide playerSide = watchPropertyValue(
      (GameViewerViewModel vm) => vm.playerSide,
    );
    Side sideToMove = watchPropertyValue(
      (GameViewerViewModel vm) => vm.sideToMove,
    );
    IMap<Square, ISet<Square>> validMoves = watchPropertyValue(
      (GameViewerViewModel vm) => vm.validMoves,
    );
    NormalMove? promotionMove = watchPropertyValue(
      (GameViewerViewModel vm) => vm.promotionMove,
    );
    NormalMove? lastMove = watchPropertyValue(
      (GameViewerViewModel vm) => vm.lastMove,
    );

    return Chessboard(
      size: MediaQuery.of(context).size.height / 1.2,
      game: GameData(
        playerSide: playerSide,
        sideToMove: sideToMove,
        validMoves: validMoves,
        promotionMove: promotionMove,
        onMove: di<GameViewerViewModel>().playMove,
        onPromotionSelection: di<GameViewerViewModel>().promotionSelection,
      ),
      orientation: orientation,
      fen: fen,
      lastMove: lastMove,
    );
  }
}
