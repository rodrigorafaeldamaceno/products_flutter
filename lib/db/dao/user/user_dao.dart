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

  Future addProduct(User user) {
    return into(users).insert(user);
  }

  Future updateProduct(User user) {
    return update(users).replace(user);
  }

  Future removeProduct(int id) {
    return (delete(users)..where((user) => user.id.equals(id))).go();
  }
}
