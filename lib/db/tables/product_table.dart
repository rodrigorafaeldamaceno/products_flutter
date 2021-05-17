import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get code => integer()();
}
