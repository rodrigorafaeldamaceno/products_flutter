import 'package:products_flutter/db/database.dart';

import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  final _dao = MyDatabase.instance.userDAO;

  Future<int> addUser(User user) {
    return _dao.addUser(user);
  }

  Future updateUser(User user) {
    return _dao.updateUser(user);
  }

  Future removeUser(int id) {
    return _dao.removeUser(id);
  }

  Stream<User> findOne() {
    try {
      return _dao.findOne();
    } catch (e) {
      return null;
    }
  }

  Future removeAllUsers() {
    return _dao.removeAllUsers();
  }
}
