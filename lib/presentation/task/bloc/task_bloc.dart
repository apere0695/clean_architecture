import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_hexagonal_bloc/domain/entities/task.dart';
import 'package:practica_hexagonal_bloc/domain/usecases/get_tasks_usecase.dart';

// Eventos
abstract class TaskEvent {}

class TaskLoadEvent extends TaskEvent {}

// Estados
abstract class TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;
  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String error;
  TaskErrorState(this.error);
}

// BLoC
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;

  TaskBloc(this.getTasksUseCase) : super(TaskLoadingState()) {
    on<TaskLoadEvent>(_onTaskLoadEvent);

    // Disparar el evento TaskLoadEvent al inicializar el Bloc
    add(TaskLoadEvent());
  }

  Future<void> _onTaskLoadEvent(
      TaskLoadEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await getTasksUseCase();
      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }
}
