import 'package:bloc/bloc.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';
import 'package:login_demo/features/authentication/presentation/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void usernameChanged(String value) {
    emit(state.copyWith(username: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> loginSubmitted() async {
    if (state.status == LoginStatus.loading) return;

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _authRepository.logIn(
        email: state.username,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
