import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanapp/l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/preferences/preference_config.dart';
import '../src/app.dart';

// GlobalKey<NavigatorState> navigatorKey = GlobalKey();
// BuildContext get appContext => navigatorKey.currentContext!;
ThemeData appTheme(BuildContext context) => Theme.of(context);
AppLocalizations appLanguage(BuildContext context) => AppLocalizations.of(context)!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ScreenUtil.ensureScreenSize();
  await initPreferences();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
