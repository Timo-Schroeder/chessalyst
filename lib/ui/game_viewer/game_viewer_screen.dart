import 'package:chessalyst/l10n/app_localizations.dart';
import 'package:chessalyst/ui/core/header_bar.dart';
import 'package:chessalyst/ui/game_viewer/widgets/analysis_board.dart';
import 'package:flutter/material.dart';

class GameViewer extends StatelessWidget {
  const GameViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(title: Text(AppLocalizations.of(context)!.title)),
      body: Row(
        children: [
          AnalysisBoard(),
          Text(AppLocalizations.of(context)!.greeting),
        ],
      ),
    );
  }
}
