import 'package:equatable/equatable.dart';

/// {@template user}
/// User entity model.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({required this.id, this.email, this.name});

  /// The unique identifier of the user.
  final String id;

  /// The email address of the user.
  final String? email;

  /// The name of the user.
  final String? name;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, name];
}
