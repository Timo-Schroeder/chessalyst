import 'package:chessalyst/domain/models/game_result.dart';
import 'package:chessalyst/ui/game_viewer/view_model/metadata_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/yaru.dart';

class MetadataForm extends StatelessWidget with WatchItMixin {
  const MetadataForm({super.key});

  @override
  Widget build(BuildContext context) {
    final event = watchPropertyValue((MetadataFormViewModel vm) => vm.event);
    final site = watchPropertyValue((MetadataFormViewModel vm) => vm.site);
    final round = watchPropertyValue((MetadataFormViewModel vm) => vm.round);
    final white = watchPropertyValue((MetadataFormViewModel vm) => vm.white);
    final black = watchPropertyValue((MetadataFormViewModel vm) => vm.black);
    final result = watchPropertyValue((MetadataFormViewModel vm) => vm.result);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Event', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(labelText: 'Event'),
          initialValue: event,
          onChanged: (value) {
            di<MetadataFormViewModel>().event = value;
          },
        ),
        const SizedBox(height: 16),
        Text('Site', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(labelText: 'Site'),
          initialValue: site,
          onChanged: (value) {
            di<MetadataFormViewModel>().site = value;
          },
        ),
        const SizedBox(height: 16),
        Text('Date', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        YaruDateTimeEntry(
          includeTime: false,
          firstDateTime: DateTime(0),
          lastDateTime: DateTime(DateTime.now().year),
          acceptEmpty: false,
          initialDateTime: DateTime.now(),
          onChanged: (date) {
            if (date != null) {
              di<MetadataFormViewModel>().date = date;
            }
          },
        ),
        const SizedBox(height: 16),
        Text('Round', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(labelText: 'Round'),
          initialValue: round,
          onChanged: (value) {
            di<MetadataFormViewModel>().round = value;
          },
        ),
        const SizedBox(height: 16),
        Text('White', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(labelText: 'White'),
          initialValue: white,
          onChanged: (value) {
            di<MetadataFormViewModel>().white = value;
          },
        ),
        const SizedBox(height: 16),
        Text('Black', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(labelText: 'Black'),
          initialValue: black,
          onChanged: (value) {
            di<MetadataFormViewModel>().black = value;
          },
        ),
        const SizedBox(height: 16),
        Text('Site', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        YaruPopupMenuButton<GameResult>(
          initialValue: result,
          child: Text(result.name),
          itemBuilder: (context) {
            return [
              for (final value in GameResult.values)
                PopupMenuItem(value: value, child: Text(value.name)),
            ];
          },
          onSelected: (value) => di<MetadataFormViewModel>().result = value,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                di<MetadataFormViewModel>().cancel();
                Navigator.maybePop(context);
              },
              child: Text('Cancel'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                di<MetadataFormViewModel>().save();
                Navigator.maybePop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}
