import 'package:chessalyst/domain/use_cases/pgn_game_use_case.dart';
import 'package:chessalyst/ui/analysis_board/view_model/analysis_board_view_model.dart';
import 'package:chessalyst/ui/game_notation/view_model/game_notation_view_model.dart';
import 'package:watch_it/watch_it.dart';

void setupLocator() {
  di.registerLazySingleton<PgnGameUseCase>(() => PgnGameUseCase());
  di.registerLazySingleton<AnalysisBoardViewModel>(
    () => AnalysisBoardViewModel(),
  );
  di.registerLazySingleton<GameNotationViewModel>(
    () => GameNotationViewModel(),
  );
}
