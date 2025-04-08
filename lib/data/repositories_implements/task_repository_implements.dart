import 'package:practica_hexagonal_bloc/domain/entities/task.dart';
import 'package:practica_hexagonal_bloc/domain/repositories/task_repositories.dart';

import '../datasources/task_api_service.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiService apiService;

  TaskRepositoryImpl(this.apiService);

  @override
  Future<List<Task>> getTasks() async {
    final taskDtos = await apiService.fetchTask();

    return taskDtos
        .map((dto) => Task(
              id: dto.id,
              title: dto.title,
              completed: dto.completed,
            ))
        .toList();
  }
}
