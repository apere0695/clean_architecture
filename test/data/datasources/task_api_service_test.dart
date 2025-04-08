import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:practica_hexagonal_bloc/core/client/http_client.dart';
import 'package:practica_hexagonal_bloc/core/exception/exception.dart';
import 'package:practica_hexagonal_bloc/data/datasources/task_api_service.dart';
import 'package:practica_hexagonal_bloc/data/models/task_dto.dart';

import 'task_api_service_test.mocks.dart';

// Generación de los mocks
@GenerateMocks([HttpClient])
void main() {
  late MockHttpClient mockHttpClient;
  late TaskApiServiceImpl taskApiService;

  setUp(() {
    mockHttpClient = MockHttpClient();
    taskApiService = TaskApiServiceImpl(mockHttpClient);
  });

  group('fetchTask', () {
    const mockResponse = '''
      [
        {"id": 1, "title": "Tarea 1", "completed": false},
        {"id": 2, "title": "Tarea 2", "completed": true}
      ]
    ''';

    test('debe retornar una lista de tareas si el status code es 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/todos')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await taskApiService.fetchTask();

      expect(result, isA<List<TaskDto>>());
      expect(result.length, 2);
      expect(result[0].title, 'Tarea 1');
      expect(result[0].completed, false);
    });

    test('debe lanzar ServerException si el status code no es 200', () {
      when(mockHttpClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/todos')))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => taskApiService.fetchTask(), throwsA(isA<ServerException>()));
    });

    test('debe lanzar ServerException en caso de error de conexión', () {
      when(mockHttpClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/todos')))
          .thenThrow(Exception('Error de conexión'));

      expect(() => taskApiService.fetchTask(), throwsA(isA<ServerException>()));
    });
  });
}
