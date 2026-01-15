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
    // TODO: implement logIn
    await Future.delayed(const Duration(milliseconds: 300), () {
      _controller.add(const User(id: 'mock_id', email: 'test@example.com'));
    });
  }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
    _controller.add(User.empty);
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    // TODO: implement signUp
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
