part of 'leaning_bloc.dart';

sealed class LeaningState {}

final class LeaningInitial extends LeaningState {}

final class LeaningLoading extends LeaningState {}

final class LeaningSuccess extends LeaningState {
  final List<NewCourseCardModel> response;

  LeaningSuccess({required this.response});
}

final class LeaningFail extends LeaningState {}

final class LeaningEmpty extends LeaningState {}
