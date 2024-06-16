import 'package:ajhman/core/enum/state_status.dart';
import 'package:ajhman/data/model/error_response_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/api/api_end_points.dart';
import '../../../data/model/auth/auth_user_otp_error.dart';

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
        } on DioError catch (e) {
          String error = 'normal';
          if (e.type == DioExceptionType.connectionError ||
              e.type == DioExceptionType.connectionTimeout) {
            error = 'connection';
          }
          emit(ProfileFail(error: error));
        }
      }
    });
  }
}
