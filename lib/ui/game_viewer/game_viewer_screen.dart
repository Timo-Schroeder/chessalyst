import 'package:chessalyst/l10n/app_localizations.dart';
import 'package:chessalyst/ui/analysis_board/view_model/analysis_board_view_model.dart';
import 'package:chessalyst/ui/core/header_bar.dart';
import 'package:chessalyst/ui/game_notation/widgets/game_notation.dart';
import 'package:chessalyst/ui/analysis_board/widgets/analysis_board.dart';
import 'package:chessalyst/ui/game_viewer/view_model/game_viewer_view_model.dart';
import 'package:chessalyst/ui/game_viewer/widgets/metadata_form.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class GameViewer extends StatelessWidget with WatchItMixin {
  const GameViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final nextMoves = watchPropertyValue(
      (AnalysisBoardViewModel vm) => vm.nextMoveOptions,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nextMoves?.isNotEmpty ?? false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                for (var move in nextMoves!)
                  OutlinedButton(
                    onPressed: () {
                      di<AnalysisBoardViewModel>().goToNextMove(move);
                      Navigator.maybePop(context);
                    },
                    child: Text(move.data.san),
                  ),
              ],
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: HeaderBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          YaruOptionButton(
            onPressed: di<GameViewerViewModel>().saveFile,
            child: Icon(YaruIcons.save),
          ),
          SizedBox(width: 8),
          YaruOptionButton(
            onPressed: () => showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                titlePadding: EdgeInsets.zero,
                title: YaruDialogTitleBar(
                  title: const Text('Metadata'),
                  isClosable: true,
                ),
                content: MetadataForm(),
              ),
            ),
            child: Icon(YaruIcons.information),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            AnalysisBoard(),
            Spacer(),
            Column(
              spacing: 16,
              children: [
                GameNotation(),
                Row(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          di<AnalysisBoardViewModel>().goToFirstMove(),
                      child: Text('<<'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          di<AnalysisBoardViewModel>().goToPreviousMove(),
                      child: Text('<'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          di<AnalysisBoardViewModel>().getNextMoveOptions(),
                      child: Text('>'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          di<AnalysisBoardViewModel>().goToLastMove(),
                      child: Text('>>'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
