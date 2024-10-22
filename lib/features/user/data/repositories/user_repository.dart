import 'package:flutter_application_1/core/database/database_helper.dart';
import 'package:flutter_application_1/features/user/data/models/user.dart';

class UserRepository {
  final DatabaseHelper databaseHelper;

  UserRepository(this.databaseHelper);

  Future<int> addUser(User user) async {
    return await databaseHelper.insertUser(user);
  }

  Future<List<User>> fetchUser() async {
    return await databaseHelper.getUsers();
  }
}
