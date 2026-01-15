import 'package:bloc/bloc.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';
import 'package:login_demo/features/authentication/presentation/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(const RegisterState());

  final AuthRepository _authRepository;

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: RegisterStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: RegisterStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: RegisterStatus.initial));
  }

  Future<void> registerSubmitted() async {
    if (state.status == RegisterStatus.loading) return;

    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      await _authRepository.signUp(
        name: state.name,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
