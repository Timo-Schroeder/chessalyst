import 'package:chessalyst/l10n/app_localizations.dart';
import 'package:chessalyst/utils/locator.dart';
import 'package:chessalyst/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/widgets.dart';

Future<void> main() async {
  await YaruWindowTitleBar.ensureInitialized();

  setupLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
