import 'package:chessalyst/l10n/app_localizations.dart';
import 'package:chessalyst/ui/game_viewer/view_model/game_viewer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class CommentForm extends StatelessWidget with WatchItMixin {
  const CommentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final addCommentBefore = watchPropertyValue(
      (GameViewerViewModel vm) => vm.addCommentBefore,
    );
    final comment = watchPropertyValue((GameViewerViewModel vm) => vm.comment);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('Add Comment before move:'),
            SizedBox(width: 16),
            YaruSwitch(
              value: addCommentBefore,
              onChanged: (value) =>
                  di<GameViewerViewModel>().addCommentBefore = value,
            ),
          ],
        ),
        SizedBox(height: 16),
        Text('Comment:'),
        SizedBox(height: 8),
        TextFormField(
          initialValue: comment,
          onChanged: (value) => di<GameViewerViewModel>().comment = value,
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.metadataCancelButtonText,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                di<GameViewerViewModel>().saveComment();
                Navigator.maybePop(context);
              },
              child: Text(AppLocalizations.of(context)!.metadataSaveButtonText),
            ),
          ],
        ),
      ],
    );
  }
}
