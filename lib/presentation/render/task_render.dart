import 'dart:math';

import 'package:flutter/material.dart';

class TaskRender extends StatefulWidget {
  const TaskRender({super.key});

  @override
  State<TaskRender> createState() => _TaskRenderState();
}

class _TaskRenderState extends State<TaskRender> {
  final List<String> frases = [
    "Sigue adelante.",
    "Hoy es un gran día.",
    "Nunca te rindas.",
    "Cree en ti.",
    "Cada día cuenta.",
    "Hazlo con pasión.",
    "El éxito es la suma de pequeños esfuerzos repetidos día tras día.",
    "La única manera de hacer un gran trabajo es amar lo que haces.",
    "El futuro pertenece a quienes creen en la belleza de sus sueños.",
    "No importa lo lento que vayas, siempre y cuando no te detengas.",
    "La disciplina es el puente entre metas y logros.",
    "La perseverancia es el secreto del éxito.",
    "Cree que puedes y estarás a medio camino.",
    "El fracaso es solo la oportunidad de comenzar de nuevo con más experiencia.",
  ];

  final Map<String, IconData> fraseIconos = {
    "Sigue adelante.": Icons.directions_walk,
    "Hoy es un gran día.": Icons.wb_sunny,
    "Nunca te rindas.": Icons.flag,
    "Cree en ti.": Icons.thumb_up,
    "Cada día cuenta.": Icons.calendar_today,
    "Hazlo con pasión.": Icons.favorite,
    "El éxito es la suma de pequeños esfuerzos repetidos día tras día.":
        Icons.trending_up,
    "La única manera de hacer un gran trabajo es amar lo que haces.":
        Icons.work,
    "El futuro pertenece a quienes creen en la belleza de sus sueños.":
        Icons.star,
    "No importa lo lento que vayas, siempre y cuando no te detengas.":
        Icons.hourglass_bottom,
    "La disciplina es el puente entre metas y logros.": Icons.check_circle,
    "La perseverancia es el secreto del éxito.": Icons.lock,
    "Cree que puedes y estarás a medio camino.": Icons.emoji_events,
    "El fracaso es solo la oportunidad de comenzar de nuevo con más experiencia.":
        Icons.refresh,
  };

  final List<String> frasesFavoritas = [];
  String fraseActual = "Presiona el botón para una frase.";
  IconData iconoActual = Icons.lightbulb_outline;
  Color fondoActual = Colors.white;

  final List<Color> colores = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
  ];

  void mostrarFraseAleatoria() {
    final random = Random();
    final nuevaFrase = frases[random.nextInt(frases.length)];
    setState(() {
      fraseActual = nuevaFrase;
      iconoActual = fraseIconos[nuevaFrase] ?? Icons.lightbulb_outline;
      fondoActual = colores[random.nextInt(colores.length)];
    });
  }

  void mostrarFavoritas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Frases Favoritas"),
          content: frasesFavoritas.isEmpty
              ? const Text("No tienes frases favoritas aún.")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: frasesFavoritas.map((frase) {
                    return ListTile(
                      title: Text(frase),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            frasesFavoritas.remove(frase);
                          });
                          Navigator.pop(context); // Cierra el diálogo
                          mostrarFavoritas(); // Lo vuelve a abrir actualizado
                        },
                      ),
                    );
                  }).toList(),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondoActual,
      appBar: AppBar(
        backgroundColor: fondoActual,
        centerTitle: true,
        title: const Text("Frases del Día"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Icon(
                  iconoActual,
                  key: ValueKey(iconoActual),
                  size: 64,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Text(
                  fraseActual,
                  key: ValueKey(fraseActual),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: mostrarFraseAleatoria,
                icon: const Icon(Icons.refresh),
                label: const Text("Nueva frase"),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (!frasesFavoritas.contains(fraseActual)) {
                      frasesFavoritas.add(fraseActual);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Frase guardada como favorita")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("La frase ya está en favoritos")),
                      );
                    }
                  });
                },
                icon: const Icon(Icons.favorite),
                label: const Text("Guardar favorita"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: mostrarFavoritas,
                child: const Text("Ver favoritas"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
