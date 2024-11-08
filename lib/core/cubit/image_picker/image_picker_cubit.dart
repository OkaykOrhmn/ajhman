// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:ajhman/core/services/image_picker.dart';
import 'package:ajhman/core/services/permission_handler.dart';
import 'package:ajhman/data/repository/profile_repository.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  void getImageFromGallery() async {
    final permission =
        await permissionHandler.requestPermission(Permission.mediaLibrary);
    if (permission) {
      final path = await imagePickerHandler.pickImageFromGallery();
      if (path != null) {
        final fileName = path.split('.').last;
        try {
          emit(ImagePickerLoading());
          FormData formData = FormData.fromMap({
            "image": await MultipartFile.fromFile(path,
                contentType: MediaType('image', fileName)),
          });
          final response = await profileRepository.putProfileImage(formData);
          final profile = await getProfile();
          profile.image = response.data["image"].toString();
          await setProfile(profile);
          emit(ImagePickerSuccess());
        } on DioError {
          emit(ImagePickerError());
        }
      } else {
        emit(ImagePickerError());
      }
    } else {
      emit(ImagePickerError());
    }
  }

  void deleteProfileImage() async {
    try {
      emit(ImagePickerLoading());
      final response = await profileRepository.deleteProfile();
      final profile = await getProfile();
      profile.image = response.data["image"].toString();
      await setProfile(profile);
      emit(ImagePickerSuccess());
    } on DioError {
      emit(ImagePickerError());
    }
  }

  void getImageFromCamera() async {
    final permission =
        await permissionHandler.requestPermission(Permission.camera);
    if (permission) {
      final path = await imagePickerHandler.pickImageFromCamera();
      if (path != null) {
        final fileName = path.split('.').last;
        try {
          emit(ImagePickerLoading());
          FormData formData = FormData.fromMap({
            "image": await MultipartFile.fromFile(path,
                contentType: MediaType('image', fileName)),
          });
          final response = await profileRepository.putProfileImage(formData);
          final profile = await getProfile();
          profile.image = response.data["image"].toString();
          await setProfile(profile);
          emit(ImagePickerSuccess());
        } on DioError {
          emit(ImagePickerError());
        }
      } else {
        emit(ImagePickerError());
      }
    } else {
      emit(ImagePickerError());
    }
  }
}
