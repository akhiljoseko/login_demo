import 'package:login_demo/features/authentication/domain/entities/user_entity.dart';

/// {@template auth_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
abstract class AuthRepository {
  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User> get user;

  /// Signs up with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password});

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logIn({required String email, required String password});

  /// Signs out the current user.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
