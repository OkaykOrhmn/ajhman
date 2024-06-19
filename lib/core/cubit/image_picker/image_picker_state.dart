part of 'image_picker_cubit.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickerSuccess extends ImagePickerState {}
final class ImagePickerError extends ImagePickerState {}

final class ImagePickerLoading extends ImagePickerState {}
