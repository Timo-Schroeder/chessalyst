// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Chessalyst';

  @override
  String get greeting => 'Hello there';

  @override
  String get metadataEventSection => 'Event';

  @override
  String get metadataEventTextFieldLabel => 'Event';

  @override
  String get metadataSiteSection => 'Site';

  @override
  String get metadataSiteTextFieldLabel => 'Site';

  @override
  String get metadataDateSection => 'Date';

  @override
  String get metadataRoundSection => 'Round';

  @override
  String get metadataRoundTextFieldLabel => 'Round';

  @override
  String get metadataWhiteSection => 'White';

  @override
  String get metadataWhiteTextFieldLabel => 'White';

  @override
  String get metadataBlackSection => 'Black';

  @override
  String get metadataBlackTextFieldLabel => 'Black';

  @override
  String get metadataResultSection => 'Result';

  @override
  String get metadataCancelButtonText => 'Cancel';

  @override
  String get metadataSaveButtonText => 'Save';
}
