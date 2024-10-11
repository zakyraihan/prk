import 'package:go_router/go_router.dart';
import 'package:mysmk_prakerin/main_screen.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/screen/login.dart';
import 'package:mysmk_prakerin/screen/splash_screen.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: Routes.splash,
      builder: (context, state) {
        return  SplashScreenView();
      },
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/main',
      name: Routes.main,
      builder: (context, state) {
        return const MainScreen();
      },
    ),
  ],
);
