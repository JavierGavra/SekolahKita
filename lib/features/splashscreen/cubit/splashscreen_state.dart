part of 'splashscreen_cubit.dart';

enum SplashscreenStatus { loading, success, failure }

final class SplashscreenState extends Equatable {
  final SplashscreenStatus status;
  final String? errorMessage;

  const SplashscreenState({required this.status, this.errorMessage});

  const SplashscreenState.initial() : this(status: SplashscreenStatus.loading);

  @override
  List<Object?> get props => [status, errorMessage];
}
