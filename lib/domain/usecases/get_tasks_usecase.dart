import 'package:practica_hexagonal_bloc/domain/repositories/task_repositories.dart';

import '../entities/task.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
