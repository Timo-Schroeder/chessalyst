import 'package:chessalyst/ui/game_viewer/game_viewer_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/game-viewer',
  routes: [
    GoRoute(
      name: 'game-viewer',
      path: '/game-viewer',
      builder: (context, state) => const GameViewer(),
    ),
  ],
);
