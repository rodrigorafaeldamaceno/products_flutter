import 'package:flutter/material.dart';
import 'package:products_flutter/db/database.dart';
import 'package:products_flutter/models/menu_choice.dart';
import 'package:products_flutter/stores/product_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ProductStore();

  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  Widget cardProduct(Product product) {
    return Card(
      child: ListTile(
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
            Text('Price: ${product.price.toStringAsFixed(2)}'),
            Text(
                'Code: ${product.code}; Date: ${product.date.year}-${product.date.month}-${product.date.day}'),
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

  Future _addProduct() async {
    _nameController.clear();
    _codeController.clear();
    _priceController.clear();

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
                  Text('Add product'),
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Code'),
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) return null;

                      await controller.addProduct(
                        Product(
                          name: _nameController.text,
                          code: int.tryParse(_codeController.text),
                          price: double.tryParse(_codeController.text),
                          date: DateTime.now(),
                        ),
                      );

                      Navigator.pop(context);
                    },
                  )
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
        onPressed: _addProduct,
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
