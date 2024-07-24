import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<double> {
  TimerCubit() : super(1);

  void setTimer(double t) async {
    emit(t);
  }
}
