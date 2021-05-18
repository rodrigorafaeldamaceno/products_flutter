import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get price => real().withDefault(Constant(0)).nullable()();
  IntColumn get code => integer()();
  IntColumn get quantity => integer().withDefault(Constant(0)).nullable()();
  DateTimeColumn get date => dateTime()();
}
