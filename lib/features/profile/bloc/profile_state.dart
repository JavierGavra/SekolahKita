part of 'profile_bloc.dart';

enum ProfileStateStatus { initial, loading, success, failure }

final class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final ProfileModel? profile;
  final String? errorMessage;

  const ProfileState({required this.status, this.profile, this.errorMessage});

  const ProfileState.initial() : this(status: ProfileStateStatus.initial);

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
