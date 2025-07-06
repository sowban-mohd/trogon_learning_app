import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogan_learning_app/data/repository/learning_app_repository.dart';
import 'package:trogan_learning_app/models/subject.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  final LearningAppRepository repository;
  SubjectsCubit(this.repository) : super(SubjectsInitial());

  Future<void> fetchSubjects() async {
    emit(SubjectsLoading());
    try {
      final List<Subject> subjects = await repository.fetchSubjects();
      emit(SubjectsSuccess(subjects));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }
}
