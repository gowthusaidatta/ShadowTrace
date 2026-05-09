import 'package:flutter/material.dart';

class GuardianContactsScreen extends StatelessWidget {
  const GuardianContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guardians = [
      {'name': 'Asha', 'phone': '+1 555 101 1001'},
      {'name': 'Maya', 'phone': '+1 555 101 1002'},
      {'name': 'Guardian Hotline', 'phone': '+1 555 101 1003'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Guardians')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final g = guardians[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shield)),
              title: Text(g['name']!),
              subtitle: Text(g['phone']!),
              trailing: IconButton(icon: const Icon(Icons.call), onPressed: () {}),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: guardians.length,
      ),
    );
  }
}
