import 'package:moor_flutter/moor_flutter.dart';
import 'package:products_flutter/db/tables/user_table.dart';

import '../../database.dart';

part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDAO extends DatabaseAccessor<MyDatabase> with _$UserDAOMixin {
  UserDAO(MyDatabase db) : super(db);

  Stream<List<User>> find() {
    return (select(users).watch());
  }

  Future<int> addUser(User user) {
    return into(users).insert(user);
  }

  Future<bool> updateUser(User user) {
    return update(users).replace(user);
  }

  Future removeUser(int id) {
    return (delete(users)..where((user) => user.id.equals(id))).go();
  }

  Stream<User> findOne() {
    return (select(users)..limit(1)).watchSingle();
  }

  Future removeAllUsers() {
    return (delete(users)).go();
  }
}
