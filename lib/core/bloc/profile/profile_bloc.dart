import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/repository/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileInfo) {
        emit(ProfileLoading());
        try {
          ProfileResponseModel response = await profileRepository.getProfile();
          emit(ProfileSuccess(response: response));
          // ignore: deprecated_member_use
        } on DioError catch (e) {
          if (e.type == DioExceptionType.connectionError ||
              e.type == DioExceptionType.connectionTimeout) {
            emit(ProfileFailConnection());
          } else {
            emit(ProfileFail());
          }
        }
      }
    });
  }
}
