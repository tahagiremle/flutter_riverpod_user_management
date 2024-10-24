import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/model/user.dart';
import 'package:flutter_application_1/features/user/viewmodel/user_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
