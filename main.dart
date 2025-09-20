import 'package:flutter/material.dart';
import 'widgets/icon_label.dart';
import 'widgets/task_card.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: ListView(
        children: const [
          TaskCard(
            title: 'Prepare for Rose Ann\'s Presentation',
            description:
                'Finalize the slides and practice the script with Rose Ann before the meeting.',
          ),
          TaskCard(
            title: 'Networking Quiz Review',
            description:
                'Study IPv6 and subnetting notes for the quiz tomorrow.',
          ),
          TaskCard(
            title: 'Flutter UI Cleanup',
            description:
                'Refactor and clean up the app code before pushing to the repository.',
          ),
          TaskCard(
            title: 'Coffee Break with Rose Ann',
            description:
                'Meet Rose Ann at the cafe after class to plan the next project.',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        String? selectedPriority = 'High';
        final titleController = TextEditingController();

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedPriority,
                    items: ['High', 'Medium', 'Low']
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => selectedPriority = v),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('(UI-only) Task created'),
                        ),
                      );
                    },
                    child: const Text('Create'),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        );
      },
    );
  }
}