import 'package:clean_architecture/widget/app_table.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data
    final users = [
      {'name': 'Aasu', 'email': 'aasu@email.com', 'address': 'Banepa'},
      {'name': 'John', 'email': 'john@email.com', 'address': 'Khopasi'},
      {'name': 'Alice', 'email': 'alice@email.com', 'address':'Panauti'},
    ];

    // Build table rows dynamically
    final rows = users.map((user) {
      return [
        Text(user['name']!),
        Text(user['email']!),
        Text(user['address']!),

        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Edit User'),
                content: Text('Edit ${user['name']}'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                ],
              ),
            );
          },
        ),
      ];
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppTable(
         columns: const ['Name', 'Email', 'Address','Action',],
          rows: rows,
        ),
      ),
    );
  }
}
