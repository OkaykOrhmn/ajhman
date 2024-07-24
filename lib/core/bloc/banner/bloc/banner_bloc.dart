// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/repository/banner_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<BannerEvent>((event, emit) async {
      if (event is GetAllBanners) {
        emit(BannerLoading());
        try {
          List<String> response = await bannerRepository.getBanners();

          emit(BannerSuccess(response: response));
        } on DioError {
          emit(BannerFail());
        }
      }
    });
  }
}
