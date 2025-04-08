import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practica_hexagonal_bloc/domain/entities/task.dart';

import '../../../domain/usescases/get_tasks_usecase_test.mocks.dart';

void main() {
  late MockGetTasksUseCase mockGetTasksUseCase;

  setUp(() {
    mockGetTasksUseCase = MockGetTasksUseCase();
  });

  test('Debería obtener una lista de tareas correctamente', () async {
    final List<Task> mockTasks = [
      Task(id: 1, title: 'Test Task', completed: false)
    ];

    when(mockGetTasksUseCase()).thenAnswer((_) async => mockTasks);

    // Act: Llamamos al método a probar
    final result = await mockGetTasksUseCase();

    // Assert: Verificamos el resultado y que el método fue llamado
    expect(result, isA<List<Task>>());
    expect(result.length, 1);
    expect(result[0].title, 'Test Task');
    expect(result[0].completed, false);

    verify(mockGetTasksUseCase()).called(1); // Se llama exactamente una vez
  });
}
