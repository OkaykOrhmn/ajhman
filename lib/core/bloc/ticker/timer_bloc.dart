import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/timer/timer.dart';


part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Timer _ticker;
  static const _duration = 10; // seconds

  /// counting down from 60

  /// to listen to the ticker stream
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Timer ticker})
      : _ticker = ticker,

  /// we have to specify the initial stage
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    /// In case of there is an subscription exists, we have to cancel it
    _tickerSubscription?.cancel();
    /// triggers the TimerRunInProgress state
    emit(TimerRunInProgress(event.duration));
    /// makes the subscription listen to TimerTicked state
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration) /// triggers the TimerRunInProgress state
        : const TimerRunComplete()); /// triggers TimerRunComplete state
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    /// As the timer pause, we should pause the subscription also
    _tickerSubscription?.pause();
    emit(TimerRunPause(state.duration)); /// triggers the TimerRunPause state
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    /// As the timer resume, we must let the subscription resume also
    _tickerSubscription?.resume();
    emit(TimerRunInProgress(state.duration)); /// triggers the TimerRunInProgress state
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    /// Timer counting finished, so we must cancel the subscription
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration)); /// triggers the TimerInitial state
  }
}