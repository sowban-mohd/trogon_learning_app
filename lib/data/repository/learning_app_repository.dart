import 'package:trogan_learning_app/data/data_source/learning_app_data_source.dart';
import 'package:trogan_learning_app/models/module.dart';
import 'package:trogan_learning_app/models/subject.dart';
import 'package:trogan_learning_app/models/video.dart';

class LearningAppRepository {
  final LearningAppDataSource dataSource;
  LearningAppRepository(this.dataSource);
  Future<List<Subject>> fetchSubjects() async {
    try {
    return await dataSource.fetchSubjects();
    } catch (e){
      throw e.toString();
    }
  }
    Future<List<Module>> fetchModules(int subjectId) async {
    try {
    return await dataSource.fetchModules(subjectId);
    } catch (e){
      throw e.toString();
    }

    
  }

  Future<List<Video>> fetchVideo(int moduleId) async {
    try {
      print('repository done');
    return await dataSource.fetchVideo(moduleId);
    } catch (e){
      throw e.toString();
    }
  }
}