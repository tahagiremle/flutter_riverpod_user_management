import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/model/user.dart';
import 'package:flutter_application_1/features/user/viewmodel/user_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserForm extends ConsumerStatefulWidget {
  const AddUserForm({super.key});

  @override
  ConsumerState<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends ConsumerState<AddUserForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

    @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New User"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final user = User(
              name: _nameController.text,
              email: _emailController.text,
            );
            ref.read(userProvider.notifier).addUser(user);
            Navigator.of(context).pop();
          },
          child: Text("Add"),
        )
      ],
    );
  }
}
