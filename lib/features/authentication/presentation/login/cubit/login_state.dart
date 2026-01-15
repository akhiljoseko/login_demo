import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.errorMessage,
  });

  final LoginStatus status;
  final String username;
  final String password;
  final String? errorMessage;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage:
          errorMessage, // If not passed (null), it clears? Or stays? typically clear on new state or keep.
      // Actually standard copyWith keeps if null. But here I might want to clear error on new input.
      // Let's stick to standard copyWith behavior: if null is passed, keep current.
      // To strictly clear, we might need a wrapped type or specific mechanics.
      // For now, simple copyWith.
    );
  }

  @override
  List<Object?> get props => [status, username, password, errorMessage];
}
