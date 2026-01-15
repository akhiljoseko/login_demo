import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.errorMessage,
  });

  final RegisterStatus status;
  final String name;
  final String email;
  final String password;
  final String? errorMessage;

  RegisterState copyWith({
    RegisterStatus? status,
    String? name,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, name, email, password, errorMessage];
}
