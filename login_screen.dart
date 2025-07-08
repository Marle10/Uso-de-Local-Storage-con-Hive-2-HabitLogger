import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void saveUserData(String email, String name) {
    var box = Hive.box('userBox');
    box.put('email', email);
    box.put('name', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continuar'),
              onPressed: () {
                saveUserData(emailController.text, nameController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
