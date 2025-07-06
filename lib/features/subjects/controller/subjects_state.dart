

part of 'subjects_cubit.dart';


sealed class SubjectsState {}

class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsSuccess extends SubjectsState {
  final List<Subject> subjects;
  SubjectsSuccess(this.subjects);
}

class SubjectsError extends SubjectsState {
  final String message;
  SubjectsError(this.message);
}
