part of 'video_cubit.dart';

sealed class VideoState {}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

class VideoError extends VideoState {
  final String message;
  VideoError(this.message);
}

class VideoSuccess extends VideoState {
  final Video video;
  VideoSuccess({required this.video});
}
