import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:products_flutter/db/tables/user_table.dart';

import 'dao/product/product_dao.dart';
import 'dao/user/user_dao.dart';
import 'tables/product_table.dart';
import 'package:moor/ffi.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Products, Users])
class MyDatabase extends _$MyDatabase {
  static MyDatabase instance = MyDatabase._internal();

  MyDatabase._internal() : super(_openConnection()) {
    productDAO = ProductDAO(this);
    userDAO = UserDAO(this);
  }

  ProductDAO productDAO;
  UserDAO userDAO;

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      beforeOpen: (details) async {
        print('version now: ${details.versionNow}');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        print('old version: $from');
        print('to version: $to');
      },
    );
  }
}
