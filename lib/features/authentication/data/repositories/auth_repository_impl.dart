import 'dart:async';

import 'package:login_demo/features/authentication/domain/entities/user_entity.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';

/// {@template auth_repository_impl}
/// Implementation of [AuthRepository].
/// {@endtemplate}
class AuthRepositoryImpl implements AuthRepository {
  /// {@macro auth_repository_impl}
  AuthRepositoryImpl();

  final _controller = StreamController<User>();

  @override
  Stream<User> get user async* {
    yield User.empty;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // Simulate successful login with a mock user
    _controller.add(
      User(id: 'mock_user_id', email: email, name: 'Mock User'),
    );
  }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
    _controller.add(User.empty);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: implement signUp
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}
