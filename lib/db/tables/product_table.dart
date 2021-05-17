import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get code => integer()();
  DateTimeColumn get date => dateTime()();
}
