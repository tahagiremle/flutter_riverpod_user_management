import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/features/user/view/widgets/add_user_form.dart';
import 'package:flutter_application_1/features/user/viewmodel/user_viewmodel.dart';
import 'package:flutter_application_1/features/user/view/widgets/user_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListPage extends ConsumerStatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: users.isEmpty
          ? Center(
              child: Text("User not found"),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddUserForm(),
          ).then((value) {
            // Dialog kapandıktan sonra kullanıcıları yeniden yükle
            ref.read(userProvider.notifier).loadUsers();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
