import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_demo/features/authentication/presentation/login/view/login_page.dart';
import 'package:login_demo/features/authentication/presentation/register/view/register_page.dart';

part 'app_router.g.dart';

final router = GoRouter(routes: $appRoutes, initialLocation: '/');

@TypedGoRoute<LoginRoute>(path: '/')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterPage();
}
