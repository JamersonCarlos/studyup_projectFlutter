part of 'metas_cubit.dart';

@immutable
abstract class MetasState {}

class MetasInitial extends MetasState {}

class MetasLoading extends MetasState {}

class MetasLoaded extends MetasState {
  final List<dynamic> metas;

  MetasLoaded({required this.metas});
 
}

class MetasError extends MetasState {}