import 'package:basic_crud_operations/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final RxList<User> _users = <User>[].obs;

  List<User> get users => _users;

  void addUser(User user) {
    _users.add(user);
  }

  void updateUser(User user) {
    final index = _users.indexWhere((element) => element.userId == user.userId);
    if (index != -1) {
      _users[index] = user;
      _users.refresh();
    }
  }

  void deleteUser(User user) {
    _users.remove(user);
  }

  void setUserList(List<User> userList) {
    _users.assignAll(userList);
  }
}
