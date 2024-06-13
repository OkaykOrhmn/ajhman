part of 'for_you_bloc.dart';

@immutable
sealed class ForYouState {}

final class ForYouInitial extends ForYouState {}
final class ForYouLoading extends ForYouState {}
final class ForYouSuccess extends ForYouState {
  final List<NewCourseCardModel> response;

  ForYouSuccess({required this.response});
}
final class ForYouFail extends ForYouState {}
