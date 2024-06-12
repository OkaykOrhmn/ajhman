import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class TimerCubit extends Cubit<double> {
  TimerCubit() : super(1);

  void setTimer(double t)async{
    emit(t);
  }
}
