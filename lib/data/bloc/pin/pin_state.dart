part of 'pin_bloc.dart';

@immutable
sealed class PinState {}

final class PinInitial extends PinState {}
final class PinSuccessState extends PinState {
  final String token;

  PinSuccessState(this.token);
}
final class PinErrorState extends PinState {
  final String error;

  PinErrorState(this.error);
}
final class PinStartState extends PinState {}
final class PinLoadingState extends PinState {}
final class PinGetAgainState extends PinState {}


