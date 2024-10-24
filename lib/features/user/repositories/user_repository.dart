import 'package:flutter_application_1/core/database/database_helper.dart';
import 'package:flutter_application_1/features/user/model/user.dart';

class UserRepository {
  final DatabaseHelper databaseHelper;

  UserRepository(this.databaseHelper);

  Future<int> addUser(User user) async {
    return await databaseHelper.insertUser(user);
  }

  Future<List<User>> fetchUser() async {
    return await databaseHelper.getUsers();
  }

  Future<int> updateUser(User user) async {
    return await databaseHelper.updateUser(user);
  }

  Future<int> removeUser(int id) async {
    return await databaseHelper.deleteUser(id);
  }
}
