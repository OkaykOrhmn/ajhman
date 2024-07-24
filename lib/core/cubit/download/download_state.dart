part of 'download_cubit.dart';

sealed class DownloadState {}

final class DownloadInitial extends DownloadState {}

final class DownloadLoading extends DownloadState {
  final int pr;

  DownloadLoading({required this.pr});
}

final class DownloadSuccess extends DownloadState {}

final class DownloadedAlready extends DownloadState {}

final class DownloadFail extends DownloadState {
  final String error;

  DownloadFail({required this.error});
}
