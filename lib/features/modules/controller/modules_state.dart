part of 'modules_cubit.dart';

abstract class ModulesState {}

class ModulesInitial extends ModulesState {}

class ModulesLoading extends ModulesState {}

class ModulesSuccess extends ModulesState {
  final List<Module> modules;
  ModulesSuccess(this.modules);
}

class ModulesError extends ModulesState {
  final String message;
  ModulesError(this.message);
}
