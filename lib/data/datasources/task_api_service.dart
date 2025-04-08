import 'dart:convert';

import 'package:practica_hexagonal_bloc/core/client/http_client.dart';
import 'package:practica_hexagonal_bloc/core/exception/exception.dart';
import 'package:practica_hexagonal_bloc/data/models/task_dto.dart';

abstract class TaskApiService {
  Future<List<TaskDto>> fetchTask();
}

class TaskApiServiceImpl implements TaskApiService {
  final HttpClient client;

  TaskApiServiceImpl(this.client);

  @override
  Future<List<TaskDto>> fetchTask() async {
    try {
      final response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((task) => TaskDto.fromJson(task))
            .toList();
      } else {
        throw ServerException('Failed to load task');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
