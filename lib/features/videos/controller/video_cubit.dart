import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogan_learning_app/data/repository/learning_app_repository.dart';
import 'package:trogan_learning_app/models/video.dart';
part 'video_state.dart';

class VideoCubit extends Cubit<VideoState>{
  final LearningAppRepository repository;
  VideoCubit(this.repository) : super(VideoInitial());

Future<void> fetchVideos(int moduleId) async {
  emit(VideoLoading());
  try {
  final videosList = await repository.fetchVideo(moduleId);
  print('boc done too');
  VideoSuccess(video: videosList[moduleId]);
  } catch (e){
    VideoError(e.toString());
  }

}  
}