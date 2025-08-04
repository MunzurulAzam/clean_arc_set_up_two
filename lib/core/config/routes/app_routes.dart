import 'package:loanapp/src/features/Exisiting_loan_screen/Exisiting_loan_screen.dart';
import 'package:loanapp/src/features/apply_loan/presentations/views/apply_loan_screen/apply_loan_screen.dart';
import 'package:loanapp/src/features/auth/presentations/views/login_screen/login_screen.dart';
import 'package:loanapp/src/features/auth/presentations/views/signup_screen/sign_up_screen.dart';
import 'package:loanapp/src/features/home_screen/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/src/features/home_screen/home_screen_test.dart';
import 'package:loanapp/src/features/loan_details_screen/loan_details_screen.dart';
import 'package:loanapp/src/features/splash_screen/splash_screen.dart';
part 'route_name.dart';

class AppRoutes {
  AppRoutes._();

  // Define the GoRouter instance
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: RouteName.test,
        name: RouteName.test,
        builder: (context, state) => const Test(),
      ),
      GoRoute(
        path: RouteName.registrationScreen,
        name: RouteName.registrationScreen,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: RouteName.loginScreen,
        name: RouteName.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.loanDetailsScreen,
        name: RouteName.loanDetailsScreen,
        builder: (context, state) => LoanDetailsScreen(
          loanDetails: state.extra as LoanDetails, // OR using path param:
          // loanId: state.params['loanId']!,
        ),
      ),
      GoRoute(
        path: RouteName.applyLoanScreen,
        name: RouteName.applyLoanScreen,
        builder: (context, state) {
          final arg = state.extra as double;
          return  ApplyLoanScreen(
            totalApprovedLoanAmount: arg,
          );
        },
      ),
      GoRoute(
        path: RouteName.existingLoanScreen,
        name: RouteName.existingLoanScreen,
        builder: (context, state) {
          return const ExistingLoanScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Page not found: ${state.name}'),
        ),
      );
    },
  );
}
