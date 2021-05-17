import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
