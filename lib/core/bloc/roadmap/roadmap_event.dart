part of 'roadmap_bloc.dart';

sealed class RoadmapEvent {}

class GetRoadMap extends RoadmapEvent {
  final int courseId;

  GetRoadMap({required this.courseId});
}
