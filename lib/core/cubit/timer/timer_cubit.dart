import 'package:bloc/bloc.dart';


class TimerCubit extends Cubit<double> {
  TimerCubit() : super(1);

  void setTimer(double t)async{
    emit(t);
  }
}
