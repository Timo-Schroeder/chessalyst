import 'package:chessalyst/ui/analysis_board/view_model/analysis_board_view_model.dart';
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
      (AnalysisBoardViewModel vm) => vm.orientation,
    );
    String fen = watchPropertyValue((AnalysisBoardViewModel vm) => vm.fen);
    PlayerSide playerSide = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.playerSide,
    );
    Side sideToMove = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.sideToMove,
    );
    IMap<Square, ISet<Square>> validMoves = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.validMoves,
    );
    NormalMove? promotionMove = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.promotionMove,
    );
    NormalMove? lastMove = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.lastMove,
    );

    return Chessboard(
      size: MediaQuery.of(context).size.height / 1.2,
      game: GameData(
        playerSide: playerSide,
        sideToMove: sideToMove,
        validMoves: validMoves,
        promotionMove: promotionMove,
        onMove: di<AnalysisBoardViewModel>().playMove,
        onPromotionSelection: di<AnalysisBoardViewModel>().promotionSelection,
      ),
      orientation: orientation,
      fen: fen,
      lastMove: lastMove,
    );
  }
}
