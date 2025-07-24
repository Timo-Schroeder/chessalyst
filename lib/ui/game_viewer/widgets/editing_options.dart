import 'package:chessalyst/ui/analysis_board/view_model/analysis_board_view_model.dart';
import 'package:chessalyst/ui/game_viewer/view_model/game_viewer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class EditingOptions extends StatelessWidget with WatchItMixin {
  const EditingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          YaruOptionButton(
            onPressed: di<AnalysisBoardViewModel>().flipBoard,
            child: Icon(YaruIcons.flip_vertical),
          ),
          YaruOptionButton(
            onPressed: di<GameViewerViewModel>().promoteLine,
            child: Icon(YaruIcons.arrow_up_outlined),
          ),
          YaruOptionButton(
            onPressed: di<GameViewerViewModel>().deleteMove,
            child: Icon(YaruIcons.trash, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
