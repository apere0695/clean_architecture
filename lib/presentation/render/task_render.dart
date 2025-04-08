import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_hexagonal_bloc/presentation/task/bloc/task_bloc.dart';

class TaskRender extends StatelessWidget {
  const TaskRender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Tareas")),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.error}")),
            );
          }
        },
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              itemCount: state.tasks.length > 15 ? 15 : state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Text(task.title);
              },
            );
          } else {
            return const Center(child: Text("No hay datos disponibles"));
          }
        },
      ),
    );
  }
}
