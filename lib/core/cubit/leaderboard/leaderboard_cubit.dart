import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<int?> {
  LeaderboardCubit({required final int? examScore}) : super(examScore);

  void setExamScore( int? examScore){
    emit(examScore);
  }
}
