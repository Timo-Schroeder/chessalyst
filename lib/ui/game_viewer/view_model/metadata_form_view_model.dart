import 'package:chessalyst/domain/models/game_result.dart';
import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:watch_it/watch_it.dart';

class MetadataFormViewModel extends SafeChangeNotifier {
  String _event = '';
  String _site = '';
  DateTime _date = DateTime.now();
  String _round = '';
  String _white = '';
  String _black = '';
  GameResult _result = GameResult.ongoing;

  String get event => _event;
  set event(String event) {
    _event = event;
    notifyListeners();
  }

  String get site => _site;
  set site(String site) {
    _site = site;
    notifyListeners();
  }

  DateTime get date => _date;
  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  String get round => _round;
  set round(String round) {
    _round = round;
    notifyListeners();
  }

  String get white => _white;
  set white(String white) {
    _white = white;
    notifyListeners();
  }

  String get black => _black;
  set black(String black) {
    _black = black;
    notifyListeners();
  }

  GameResult get result => _result;
  set result(GameResult result) {
    _result = result;
    notifyListeners();
  }

  void cancel() {
    _event = '';
    _site = '';
    _date = DateTime.now();
    _round = '';
    _white = '';
    _black = '';
    _result = GameResult.ongoing;
    notifyListeners();
  }

  void save() {
    di<PgnGameUseCase>().eventHeader = _event;
    di<PgnGameUseCase>().siteHeader = _site;
    di<PgnGameUseCase>().dateHeader =
        '${_date.year}.${_date.month < 10 ? '0${_date.month}' : _date.month}.${date.day < 10 ? '0${date.day}' : date.day}';
    di<PgnGameUseCase>().roundHeader = _round;
    di<PgnGameUseCase>().whiteHeader = _white;
    di<PgnGameUseCase>().blackHeader = _black;
    di<PgnGameUseCase>().resultHeader = _result.name;
  }
}
