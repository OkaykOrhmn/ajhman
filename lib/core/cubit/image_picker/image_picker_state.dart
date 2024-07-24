part of 'image_picker_cubit.dart';

sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickerSuccess extends ImagePickerState {}

final class ImagePickerError extends ImagePickerState {}

final class ImagePickerLoading extends ImagePickerState {}
