// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/repository/mark_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkCubit extends Cubit<MarkState> {
  MarkCubit(bool b) : super(MarkState(mark: b, markStatus: MarkStatus.init));

  void postMark(int id) async {
    emit(MarkState(mark: state.mark, markStatus: MarkStatus.loading));
    try {
      Response response = await markRepository.postMark(id);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        emit(MarkState(mark: true, markStatus: MarkStatus.success));
      } else {
        emit(MarkState(mark: state.mark, markStatus: MarkStatus.fail));
      }
    } on DioError {
      emit(MarkState(mark: state.mark, markStatus: MarkStatus.fail));
    }
  }

  void deleteMark(int id) async {
    try {
      Response response = await markRepository.deleteMark(id);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        emit(MarkState(mark: false, markStatus: MarkStatus.success));
      } else {
        emit(MarkState(mark: state.mark, markStatus: MarkStatus.fail));
      }
    } on DioError {
      emit(MarkState(mark: state.mark, markStatus: MarkStatus.fail));
    }
  }

  void getMark(bool b) {
    emit(MarkState(mark: b, markStatus: MarkStatus.success));
  }
}

class MarkState {
  bool mark;
  MarkStatus markStatus;

  MarkState({required this.mark, required this.markStatus});
}

enum MarkStatus { init, loading, success, fail }
