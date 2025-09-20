import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';              
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // usa tu firebase_options.dart
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // pantalla principal
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _guardarVariasCitas(BuildContext context) async {
    final citas = [
      {'paciente': 'Erick Estrella', 'motivo': 'Revisión general', 'fecha': '2025-09-30'},
      {'paciente': 'María López', 'motivo': 'Consulta dental', 'fecha': '2025-10-01'},
      {'paciente': 'Juan Pérez', 'motivo': 'Chequeo anual', 'fecha': '2025-10-02'},
      {'paciente': 'Lucía Torres', 'motivo': 'Dolor de cabeza', 'fecha': '2025-10-03'},
      {'paciente': 'Carlos Ramírez', 'motivo': 'Control de presión', 'fecha': '2025-10-04'},
      {'paciente': 'Ana Martínez', 'motivo': 'Dolor estomacal', 'fecha': '2025-10-05'},
      {'paciente': 'Pedro Sánchez', 'motivo': 'Examen de sangre', 'fecha': '2025-10-06'},
      {'paciente': 'Laura Gómez', 'motivo': 'Revisión pediátrica', 'fecha': '2025-10-07'},
      {'paciente': 'Diego Rivera', 'motivo': 'Lesión en rodilla', 'fecha': '2025-10-08'},
      {'paciente': 'Sofía Herrera', 'motivo': 'Vacunación', 'fecha': '2025-10-09'},
    ];

    for (var cita in citas) {
      await FirebaseFirestore.instance.collection('DocApp').add({
        ...cita,
        'creadoEn': FieldValue.serverTimestamp(),
      });
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Citas guardadas ✅')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Firebase')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _guardarVariasCitas(context),
          child: const Text('Guardar citas demo'),
        ),
      ),
    );
  }
}
