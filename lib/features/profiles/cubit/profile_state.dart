part of 'profile_cubit.dart';

enum ProfileStateStatus { loading, success, failure }

final class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final ProfileModel? profile;
  final String? errorMessage;

  const ProfileState({required this.status, this.profile, this.errorMessage});

  const ProfileState.initial() : this(status: ProfileStateStatus.loading);

  ProfileState copyWith({
    ProfileStateStatus? status,
    ProfileModel? profile,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
