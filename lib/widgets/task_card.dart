import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            Row(
              children: const [
                IconLabel(
                  icon: Icons.access_time,
                  label: "Due Today",
                  color: Colors.orange,
                ),
                SizedBox(width: 12),
                IconLabel(
                  icon: Icons.person,
                  label: "Assigned to Me",
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}