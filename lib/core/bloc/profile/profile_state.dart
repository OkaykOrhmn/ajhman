part of 'profile_bloc.dart';

@immutable
class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final ProfileResponseModel response;

  ProfileSuccess({required this.response});
}
class ProfileFail extends ProfileState {
  final String error;

  ProfileFail({required this.error});
}