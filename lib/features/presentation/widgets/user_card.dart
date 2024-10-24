import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/providers/user_provider.dart';
import 'package:flutter_application_1/features/user/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCard extends ConsumerWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          user.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(user.email, style: TextStyle(fontSize: 14)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              showDialog(
                context: context,
                builder: (context) {
                  return EditUserDialog(user: user);
                },
              );
            } else if (value == "delete") {
              ref.read(userProvider.notifier).deleteUser(user.id!);
            }
          },
          itemBuilder: (context) {
            return ['edit', 'delete'].map((String choice) {
              return PopupMenuItem<String>(
                child: Text(choice == 'edit' ? 'Edit' : 'Delete'),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

class EditUserDialog extends ConsumerWidget {
  final User user;

  const EditUserDialog({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    return AlertDialog(
      title: Text('Edit User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
            onPressed: () {
              final updatedUser = User(
                id: user.id,
                name: nameController.text,
                email: emailController.text,
              );
              ref.read(userProvider.notifier).updateUser(updatedUser);
              Navigator.of(context).pop();
            },
            child: Text("Save"))
      ],
    );
  }
}
