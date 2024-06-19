import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class PlannerCubit extends Cubit<PlannerRequestModel> {
  PlannerCubit() : super(PlannerRequestModel(startAt: "01:01"));

  void setData(PlannerRequestModel plannerRequestModel){
    emit(plannerRequestModel);
  }
}
