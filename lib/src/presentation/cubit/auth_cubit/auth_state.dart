import 'package:equatable/equatable.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/presentation/core/enums/auth_enum.dart';

abstract class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user = const User.empty(),
  });

  @override
  List<Object> get props => [status, user];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated(User user)
      : super(status: AuthStatus.authenticated, user: user);
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState()
      : super(status: AuthStatus.authenticating, user: const User.empty());
}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState(this.message)
      : super(status: AuthStatus.unknown, user: const User.empty());
}
