part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class CreateProfile extends ProfileEvent {
  final String avatar;
  final String username;

  const CreateProfile({required this.avatar, required this.username});

  @override
  List<Object> get props => [avatar, username];
}

final class GetProfile extends ProfileEvent {}
