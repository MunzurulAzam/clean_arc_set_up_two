import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanapp/core/config/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class SplashNotifier extends StateNotifier<void> {
  Timer? timer;

  SplashNotifier() : super(null);

  Future<void> init(BuildContext context) async {
    timer = Timer(const Duration(seconds: 1), () {
      goNext(context);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void goNext(BuildContext context) {
    GoRouter.of(context).go(RouteName.loginScreen);
  }
}

final splashNotifierProvider = StateNotifierProvider<SplashNotifier, void>((ref) {
  return SplashNotifier();
});
