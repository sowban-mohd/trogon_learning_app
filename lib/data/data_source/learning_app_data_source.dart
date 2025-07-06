import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:trogan_learning_app/models/module.dart';
import 'package:trogan_learning_app/models/subject.dart';
import 'package:trogan_learning_app/models/video.dart';

class LearningAppDataSource {
  final Dio dio;
  LearningAppDataSource(this.dio);
  Future<List<Subject>> fetchSubjects() async {
    try {
      final response = await dio.get('subjects.php');
      List<dynamic> subjectsList = json.decode(response.data);  
      return subjectsList.map((subject) => Subject.fromJson(subject)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

   Future<List<Module>> fetchModules(int subjectId) async {
    try {
      final response = await dio.get('modules.php?subject_id=$subjectId');
      List<dynamic> modulesList = json.decode(response.data);  
      return modulesList.map((subject) => Module.fromJson(subject)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

   Future<List<Video>> fetchVideo(int moduleId) async {
    try {
      final response = await dio.get('videos.php?module_id=$moduleId');
      final List<dynamic> videoList = json.decode(response.data);
      print('datasource done');
      return videoList.map((video) => Video.fromJson(video)).toList();
     
    } catch (e) {
      throw e.toString();
    }
  }
}
