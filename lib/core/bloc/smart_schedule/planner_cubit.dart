import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlannerCubit extends Cubit<PlannerRequestModel> {
  PlannerCubit() : super(PlannerRequestModel(startAt: "01:01"));

  void setData(PlannerRequestModel plannerRequestModel) {
    emit(plannerRequestModel);
  }
}
