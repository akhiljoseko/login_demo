import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_demo/features/authentication/domain/entities/user_entity.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.unknown()) {
    _authSubscription = _authRepository.user.listen(
      (user) => emit(
        user.isNotEmpty
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated(),
      ),
    );
  }

  final AuthRepository _authRepository;
  // ignore: cancel_subscriptions
  late final StreamSubscription<User> _authSubscription;

  Future<void> logOut() => _authRepository.logOut();

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
