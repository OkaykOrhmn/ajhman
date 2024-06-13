part of 'treasure_bloc.dart';

@immutable
sealed class TreasureState {}

final class TreasureInitial extends TreasureState {}
final class TreasureLoading extends TreasureState {}
final class TreasureSuccess extends TreasureState {
  final MyTreasureModel response;

  TreasureSuccess({required this.response});
}
final class TreasureFail extends TreasureState {}
