import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanapp/core/preferences/preferences.dart';

class MainNotifier extends StateNotifier<Map<String, dynamic>> {
  MainNotifier()
      : super({
          'locale': const Locale('en', ''),
          'themeMode': ThemeMode.light,
        }) {
    _init();
  }

  Future<void> _init() async {
    final getCode = sharedPrefCurrentLocalization.value;
    bool isAppDark = sharedPrefTheme.value;
    final local = Locale(getCode, '');

    state = {
      'locale': local,
      'themeMode': isAppDark ? ThemeMode.dark : ThemeMode.light,
    };
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await sharedPrefTheme.updateValue(themeMode == ThemeMode.dark);
    state = {
      ...state,
      'themeMode': themeMode,
    };
  }

  Future<void> updateLocale(String langCode) async {
    final local = Locale(langCode, '');
    await sharedPrefCurrentLocalization.updateValue(langCode);
    state = {
      ...state,
      'locale': local,
    };
  }
}

final mainNotifierProvider = StateNotifierProvider<MainNotifier, Map<String, dynamic>>((ref) {
  return MainNotifier();
});
