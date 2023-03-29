import 'package:ecosystem/core/route/route.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:ecosystem/modules/screen/home_layout.dart';
import 'package:ecosystem/modules/screen/login.dart';
import 'package:ecosystem/modules/screen/onboardingscreen.dart';
import 'package:ecosystem/modules/screen/prodetails/productdetails.dart';
import 'package:ecosystem/modules/screen/signup.dart';
import 'package:ecosystem/modules/screen/splash_Screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter
{
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteApp.splashscreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: RouteApp.onboarding,
                  builder: (context, GoRouterState state) =>
                   OnBoardingScreen(),
                ),
      GoRoute(
        path: RouteApp.signup,
        builder: (context, GoRouterState state) =>
            SignupScreen(),
      ),
      GoRoute(
        path: RouteApp.login,
        builder: (context, GoRouterState state) =>
            LoginScreen(),
      ),
      GoRoute(
        path: RouteApp.home,
        builder: (context, GoRouterState state) =>
            HomeLayout(),
      ),

    ],
  );

}




