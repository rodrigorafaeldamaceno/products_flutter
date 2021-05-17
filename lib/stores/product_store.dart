import 'package:mobx/mobx.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:products_flutter/db/database.dart';
import 'package:products_flutter/models/menu_choice.dart';
part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  final _dao = MyDatabase.instance.productDAO;

  GeneratedColumn orderBy;

  final menuChoices = [
    MenuChoice(
      label: 'Code',
      orderBy: MyDatabase.instance.products.code,
    ),
    MenuChoice(
      label: 'Date',
      orderBy: MyDatabase.instance.products.date,
    ),
    MenuChoice(
      label: 'Name',
      orderBy: MyDatabase.instance.products.name,
    ),
    MenuChoice(
      label: 'Price',
      orderBy: MyDatabase.instance.products.price,
    ),
  ];

  Stream<List<Product>> find() {
    return _dao.find(orderBy: orderBy);
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
