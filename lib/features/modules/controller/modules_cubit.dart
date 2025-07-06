import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogan_learning_app/data/repository/learning_app_repository.dart';
import 'package:trogan_learning_app/models/module.dart';

part 'modules_state.dart';

class ModulesCubit extends Cubit<ModulesState> {
  final LearningAppRepository repository;
  ModulesCubit(this.repository) : super(ModulesInitial());

  Future<void> fetchModules(int subjectId) async {
    emit(ModulesLoading());
    try {
      final List<Module> modules = await repository.fetchModules(subjectId);
      emit(ModulesSuccess(modules));
    } catch (e) {
      emit(ModulesError(e.toString()));
    }
  }
}
