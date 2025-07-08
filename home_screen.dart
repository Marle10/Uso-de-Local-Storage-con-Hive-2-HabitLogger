import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box habitBox;

  @override
  void initState() {
    super.initState();
    habitBox = Hive.box('habitsBox');
  }

  String getUserName() {
    var box = Hive.box('userBox');
    return box.get('name', defaultValue: 'Usuario');
  }

  void toggleHabit(String key) {
    bool current = habitBox.get(key, defaultValue: false);
    habitBox.put(key, !current);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final habits = habitBox.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola, ${getUserName()} 👋'),
      ),
      body: habits.isEmpty
          ? const Center(child: Text('No tienes hábitos aún.'))
          : ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                final completed = habitBox.get(habit);
                return CheckboxListTile(
                  title: Text(habit),
                  value: completed,
                  onChanged: (_) => toggleHabit(habit),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen()),
          );
          setState(() {});
        },
      ),
    );
  }
}
