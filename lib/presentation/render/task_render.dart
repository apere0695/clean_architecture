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
  ];

  String fraseActual = "Presiona el botón para una frase.";

  void mostrarFraseAleatoria() {
    final random = Random();
    final nuevaFrase = frases[random.nextInt(frases.length)];
    setState(() {
      fraseActual = nuevaFrase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Frases del Día"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lightbulb_outline,
                  size: 64, color: Colors.amber),
              const SizedBox(height: 24),
              Text(
                fraseActual,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: mostrarFraseAleatoria,
                icon: const Icon(Icons.refresh),
                label: const Text("Nueva frase"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
