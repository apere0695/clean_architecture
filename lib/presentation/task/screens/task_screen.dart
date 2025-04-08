import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_hexagonal_bloc/core/injection/service_locator.dart';
import 'package:practica_hexagonal_bloc/domain/usecases/get_tasks_usecase.dart';
import 'package:practica_hexagonal_bloc/presentation/render/task_render.dart';
import 'package:practica_hexagonal_bloc/presentation/task/bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaskBloc(sl<GetTasksUseCase>()),
        child: const TaskRender());
  }
}
