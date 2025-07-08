import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Box habitBox = Hive.box('habitsBox');

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar hábito')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Nombre del hábito'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  habitBox.put(controller.text, false); // No completado aún
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
