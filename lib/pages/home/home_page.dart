import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:products_flutter/db/database.dart';
import 'package:products_flutter/models/menu_choice.dart';
import 'package:products_flutter/stores/product_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ProductStore();

  final _formKey = GlobalKey<FormState>();

  Widget cardProduct(Product product) {
    return Card(
      child: ListTile(
        onTap: () {
          _openProduct(product: product);
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${product.name}'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text('Code: ${product.code}'),
            Text(
                'Date: ${product.date.year}-${product.date.month}-${product.date.day}')
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                controller.removeProduct(product.id);
              },
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  Future _openProduct({Product product}) async {
    if (product == null) {
      controller.nameController.clear();
      controller.codeController.clear();
      controller.priceController.clear();
    } else {
      controller.nameController.text = product.name;
      controller.codeController.text = product.code.toString();
      controller.priceController.text = product.price.toString();
    }

    controller.checkButton();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(product == null ? 'Add product' : 'Edit product'),
                  TextFormField(
                    controller: controller.codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Code'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (_) {
                      controller.checkButton();
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (_) {
                      controller.checkButton();
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Price'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (_) {
                      controller.checkButton();
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Observer(builder: (_) {
                    return ElevatedButton(
                      child: Text(product == null ? 'Add' : 'Edit'),
                      onPressed: !controller.buttonEnabled
                          ? null
                          : () async {
                              if (!_formKey.currentState.validate())
                                return null;

                              if (product == null) {
                                await controller.addProduct(
                                  Product(
                                    name: controller.nameController.text,
                                    code: int.tryParse(
                                        controller.codeController.text),
                                    price: double.tryParse(
                                        controller.priceController.text),
                                    date: DateTime.now(),
                                  ),
                                );
                              } else {
                                await controller.updateProduct(product.copyWith(
                                  name: controller.nameController.text,
                                  code: int.tryParse(
                                      controller.codeController.text),
                                  price: double.tryParse(
                                      controller.priceController.text),
                                  date: DateTime.now(),
                                ));
                              }

                              Navigator.pop(context);
                            },
                    );
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          PopupMenuButton<MenuChoice>(
            onSelected: (choice) {
              setState(() {
                controller.orderBy = choice.orderBy;
              });
            },
            itemBuilder: (BuildContext context) {
              return controller.menuChoices.map((choice) {
                return PopupMenuItem<MenuChoice>(
                  value: choice,
                  child: Text(
                    choice.label,
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openProduct();
        },
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: controller.find(),
          initialData: <Product>[],
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (!snapshot.hasData) return Container();

            return ListView.separated(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (ctx, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return cardProduct(snapshot.data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
