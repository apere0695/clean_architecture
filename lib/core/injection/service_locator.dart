import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:practica_hexagonal_bloc/core/client/http_client.dart';
import 'package:practica_hexagonal_bloc/data/datasources/task_api_service.dart';
import 'package:practica_hexagonal_bloc/data/repositories_implements/task_repository_implements.dart';
import 'package:practica_hexagonal_bloc/domain/repositories/task_repositories.dart';
import 'package:practica_hexagonal_bloc/domain/usecases/get_tasks_usecase.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Inyectamos http.Client
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<HttpClient>(() => HttpClientImpl(sl<http.Client>()));

  // Inyectamos el servicio API
  sl.registerLazySingleton<TaskApiService>(() => TaskApiServiceImpl(sl()));

  // Inyectamos el repositorio con su implementación
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // Inyectamos el caso de uso
  sl.registerLazySingleton<GetTasksUseCase>(
      () => GetTasksUseCase(sl<TaskRepository>()));
}
