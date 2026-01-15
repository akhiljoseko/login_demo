import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_demo/features/authentication/presentation/pages/auth_screen.dart';

part 'app_router.g.dart';

final router = GoRouter(routes: $appRoutes, initialLocation: '/');

@TypedGoRoute<AuthRoute>(path: '/')
class AuthRoute extends GoRouteData with $AuthRoute {
  const AuthRoute();

  @override
  AuthScreen build(context, state) => const AuthScreen();
}
