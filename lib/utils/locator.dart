import 'package:chessalyst/ui/game_viewer/view_model/game_viewer_view_model.dart';
import 'package:watch_it/watch_it.dart';

void setupLocator() {
  di.registerLazySingleton<GameViewerViewModel>(() => GameViewerViewModel());
}
