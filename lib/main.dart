import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static final _demoTasks = [
    {
      'title': 'Prepare for Rose Ann Presentation (Updated)',
      'description': 'Finalize slides and practice with Rose Ann.',
      'priority': 'High',
      'dueDate': 'Today',
      'assignee': 'Rose Ann'
    },
    {
      'title': 'AppDev Quiz Review',
      'description': 'Study and subnetting notes.',
      'priority': 'Medium',
      'dueDate': 'Tomorrow',
      'assignee': 'Joy'
    },
    {
      'title': 'Flutter UI Cleanup',
      'description': 'Refactor and clean up the app code.',
      'priority': 'Low',
      'dueDate': 'Friday',
      'assignee': 'Richie Ann'
    },
    {
      'title': 'Software Engineering Quiz',
      'description':
          'Read chapters 4–6 and review lecture notes for the SE quiz.',
      'priority': 'High',
      'dueDate': 'Next Tuesday',
      'assignee': 'Self'
    },
    {
      'title': 'Professional Communication Report',
      'description':
          'Write and format the final report for the ProffCom subject.',
      'priority': 'Medium',
      'dueDate': 'Next Thursday',
      'assignee': 'Team'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: ListView.builder(
        itemCount: _demoTasks.length,
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
            dueDate: t['dueDate'],
            assignee: t['assignee'],
          );
        },
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
        final descController = TextEditingController();

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
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedPriority,
                    items: ['High', 'Medium', 'Low']
                        .map((p) =>
                            DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedPriority = v),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '(UI-only) Task created with $selectedPriority priority'),
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