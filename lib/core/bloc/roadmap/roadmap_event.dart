part of 'roadmap_bloc.dart';

@immutable
sealed class RoadmapEvent {}

class GetRoadMap extends RoadmapEvent{
  final int courseId;

  GetRoadMap({required this.courseId});
}