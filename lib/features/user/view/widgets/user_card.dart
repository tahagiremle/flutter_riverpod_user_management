import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user/model/user.dart';
import 'package:flutter_application_1/features/user/view/widgets/edit_user_dialog.dart';
import 'package:flutter_application_1/features/user/viewmodel/user_viewmodel.dart';
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Deletion confirmation'),
                    content: Text(
                        'Are you sure you want to delete the user named ${user.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            ref
                                .read(userProvider.notifier)
                                .deleteUser(user.id!);
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${user.name} Deleted'),
                                backgroundColor: Colors.red,
                              ),
                            );

                            ref.read(userProvider.notifier).loadUsers();
                          },
                          child: Text('Delete'))
                    ],
                  );
                },
              );
            }
          },
          itemBuilder: (context) {
            return ['edit', 'delete'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice == 'edit' ? 'Edit' : 'Delete'),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
