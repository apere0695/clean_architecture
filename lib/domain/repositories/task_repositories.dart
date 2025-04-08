import 'package:practica_hexagonal_bloc/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
}
