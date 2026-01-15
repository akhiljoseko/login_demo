import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/router/app_router.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';
import 'package:login_demo/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:login_demo/features/authentication/presentation/register/cubit/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(context.read<AuthRepository>()),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Registration Failure'),
                ),
              );
          }
        },
        child: const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: _RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RegisterCubit>().state;
    final isLoading = state.status == RegisterStatus.loading;
    final isSuccess = state.status == RegisterStatus.success;

    if (isSuccess) {
      return const Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 64),
          SizedBox(height: 16),
          Text('Registration Successful!', style: TextStyle(fontSize: 24)),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          key: const Key('registerForm_nameInput_textField'),
          onChanged: (name) => context.read<RegisterCubit>().nameChanged(name),
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          enabled: !isLoading,
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('registerForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<RegisterCubit>().emailChanged(email),
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          enabled: !isLoading,
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('registerForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<RegisterCubit>().passwordChanged(password),
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          enabled: !isLoading,
        ),
        const SizedBox(height: 24),
        if (isLoading)
          const CircularProgressIndicator()
        else
          ElevatedButton(
            key: const Key('registerForm_continue_raisedButton'),
            onPressed: () {
              context.read<RegisterCubit>().registerSubmitted();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Register'),
          ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: !isLoading ? () => const LoginRoute().go(context) : null,
          child: const Text('Already have an account? Login'),
        ),
      ],
    );
  }
}
