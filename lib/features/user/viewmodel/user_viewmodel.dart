import 'package:flutter_application_1/core/database/database_helper.dart';
import 'package:flutter_application_1/features/user/repositories/user_repository.dart';
import 'package:flutter_application_1/features/user/model/user.dart';
import 'package:riverpod/riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserNotifier(userRepository);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final databaseHelper = DatabaseHelper();
  return UserRepository(databaseHelper);
});

class UserNotifier extends StateNotifier<List<User>> {
  final UserRepository userRepository;

  UserNotifier(this.userRepository) : super([]);

  Future<void> loadUsers() async {
    final users = await userRepository.fetchUser();
    state = users;
  }

  Future<void> addUser(User user) async {
    await userRepository.addUser(user);
    await loadUsers();
  }

  Future<void> updateUser(User user) async {
    await userRepository.updateUser(user);
    await loadUsers();
  }

  Future<void> deleteUser(int id) async {
    await userRepository.removeUser(id);
    await loadUsers();
  }
}
