import 'package:moor_flutter/moor_flutter.dart';
import 'package:products_flutter/db/tables/product_table.dart';

import '../../database.dart';

part 'product_dao.g.dart';

@UseDao(tables: [Products])
class ProductDAO extends DatabaseAccessor<MyDatabase> with _$ProductDAOMixin {
  ProductDAO(MyDatabase db) : super(db);

  Stream<List<Product>> find({GeneratedColumn orderBy}) {
    return (select(products)
          ..orderBy([
            (u) => OrderingTerm(
                  expression: orderBy ?? products.name,
                  mode: OrderingMode.asc,
                ),
          ]))
        .watch();
  }

  Future addProduct(Product product) {
    return into(products).insert(product);
  }

  Future updateProduct(Product product) {
    return update(products).replace(product);
  }

  Future removeProduct(int id) {
    return (delete(products)..where((product) => product.id.equals(id))).go();
  }
}
