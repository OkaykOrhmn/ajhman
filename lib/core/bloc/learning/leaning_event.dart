part of 'leaning_bloc.dart';

@immutable
sealed class LeaningEvent {}
class GetCards extends LeaningEvent{
  final String path;

  GetCards({required this.path});

}
