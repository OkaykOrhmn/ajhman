part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final StateStatus status;
  final String type;
  final dynamic data;

  const ProfileState({this.status = StateStatus.loading, this.type = '', this.data});

  ProfileState copyWith(
      {required StateStatus status,required String type, dynamic data}) {
    return ProfileState(status: status , type: type, data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, type];
}
