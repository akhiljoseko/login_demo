import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/router/app_router.dart';
import 'package:login_demo/features/authentication/domain/repositories/auth_repository.dart';
import 'package:login_demo/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:login_demo/features/authentication/presentation/login/cubit/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
        },
        child: const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    final isLoading = state.status == LoginStatus.loading;
    final isSuccess = state.status == LoginStatus.success;

    if (isSuccess) {
      return const Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 64),
          SizedBox(height: 16),
          Text('Login Successful!', style: TextStyle(fontSize: 24)),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
          enabled: !isLoading,
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
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
            key: const Key('loginForm_continue_raisedButton'),
            onPressed: () {
              context.read<LoginCubit>().loginSubmitted();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Login'),
          ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: !isLoading
              ? () => const RegisterRoute().go(context)
              : null,
          child: const Text('Don’t have an account? Register'),
        ),
      ],
    );
  }
}
