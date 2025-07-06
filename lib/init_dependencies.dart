import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:trogan_learning_app/data/data_source/learning_app_data_source.dart';
import 'package:trogan_learning_app/data/repository/learning_app_repository.dart';
import 'package:trogan_learning_app/features/modules/controller/modules_cubit.dart';
import 'package:trogan_learning_app/features/subjects/controller/subjects_cubit.dart';
import 'package:trogan_learning_app/features/videos/controller/video_cubit.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://trogon.info/interview/php/api/';
    dio.options.connectTimeout = Duration(seconds: 20);
    dio.options.receiveTimeout = Duration(seconds: 20);
    return dio;
  });
  serviceLocator.registerFactory<LearningAppDataSource>(() => LearningAppDataSource(serviceLocator()));
  serviceLocator.registerFactory<LearningAppRepository>(()=> LearningAppRepository(serviceLocator()));
  serviceLocator.registerFactory<SubjectsCubit>(()=> SubjectsCubit(serviceLocator()));
  serviceLocator.registerFactory<ModulesCubit>(()=> ModulesCubit(serviceLocator()));
  serviceLocator.registerFactory<VideoCubit>(() => VideoCubit(serviceLocator()));
}
