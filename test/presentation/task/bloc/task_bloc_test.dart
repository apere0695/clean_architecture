import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practica_hexagonal_bloc/domain/entities/task.dart';
import 'package:practica_hexagonal_bloc/presentation/task/bloc/task_bloc.dart';

import '../../../domain/usescases/get_tasks_usecase_test.mocks.dart';

void main() {
  late MockGetTasksUseCase mockGetTasksUseCase;

  setUp(() {
    mockGetTasksUseCase = MockGetTasksUseCase();
  });

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoadingState, TaskLoadedState] when tasks are fetched successfully',
    build: () {
      print('Building TaskBloc...');
      return TaskBloc(mockGetTasksUseCase);
    },
    act: (bloc) {
      print('Simulating successful fetch...');
      when(mockGetTasksUseCase()).thenAnswer((_) async => [
            Task(id: 1, title: 'Task 1', completed: false),
            Task(id: 2, title: 'Task 2', completed: true),
          ]);
      print('Event TaskLoadEvent added.');
    },
    expect: () {
      print('Expecting TaskLoadingState and TaskLoadedState...');
      return [
        isA<TaskLoadingState>(),
        isA<TaskLoadedState>()
            .having((state) => state.tasks.length, 'tasks length', 2),
      ];
    },
    verify: (bloc) {
      verify(mockGetTasksUseCase()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoadingState, TaskErrorState] when fetching tasks fails',
    build: () {
      print('Building TaskBloc...');
      return TaskBloc(mockGetTasksUseCase);
    },
    act: (bloc) {
      print('Simulating fetch failure...');
      when(mockGetTasksUseCase()).thenThrow(Exception('Failed to fetch tasks'));
      print('Event TaskLoadEvent added.');
    },
    expect: () {
      print('Expecting TaskLoadingState and TaskErrorState...');
      return [
        isA<TaskLoadingState>(),
        isA<TaskErrorState>().having(
            (state) => state.error, 'error', contains('Failed to fetch tasks')),
      ];
    },
    verify: (bloc) {
      verify(mockGetTasksUseCase()).called(1);
    },
  );
}
