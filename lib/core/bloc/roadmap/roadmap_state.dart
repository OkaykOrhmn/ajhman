part of 'roadmap_bloc.dart';


@immutable
class RoadmapState extends Equatable {
  final StateStatus status;
  final RoadmapModel? data;

  const RoadmapState({this.status = StateStatus.loading, this.data});

  RoadmapState copyWith(
      {required StateStatus status,required String type, RoadmapModel? data}) {
    return RoadmapState(status: status , data: data ?? this.data);
  }

  @override
  List<Object> get props => [status];
}
