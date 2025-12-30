part of 'auth_bloc.dart';

enum AuthStateStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

final class AuthState extends Equatable {
  final AuthStateStatus status;
  final String? errorMessage;

  const AuthState({required this.status, this.errorMessage});

  const AuthState.initial() : this(status: AuthStateStatus.initial);

  @override
  List<Object?> get props => [status, errorMessage];
}
