// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStoreBase, Store {
  final _$buttonEnabledAtom = Atom(name: '_ProductStoreBase.buttonEnabled');

  @override
  bool get buttonEnabled {
    _$buttonEnabledAtom.reportRead();
    return super.buttonEnabled;
  }

  @override
  set buttonEnabled(bool value) {
    _$buttonEnabledAtom.reportWrite(value, super.buttonEnabled, () {
      super.buttonEnabled = value;
    });
  }

  final _$_ProductStoreBaseActionController =
      ActionController(name: '_ProductStoreBase');

  @override
  bool checkButton() {
    final _$actionInfo = _$_ProductStoreBaseActionController.startAction(
        name: '_ProductStoreBase.checkButton');
    try {
      return super.checkButton();
    } finally {
      _$_ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
buttonEnabled: ${buttonEnabled}
    ''';
  }
}
