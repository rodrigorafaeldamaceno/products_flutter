import 'package:mobx/mobx.dart';
import 'package:products_flutter/db/database.dart';
part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  final _dao = MyDatabase.instance.productDAO;

  Stream<List<Product>> find() {
    return _dao.find();
  }

  Future addProduct(Product product) {
    return _dao.addProduct(product);
  }

  Future updateProduct(Product product) {
    return _dao.updateProduct(product);
  }

  Future removeProduct(int id) {
    return _dao.removeProduct(id);
  }
}
