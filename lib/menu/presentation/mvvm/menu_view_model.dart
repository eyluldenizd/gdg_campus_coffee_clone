import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/menu/domain/entity/product.dart';
import 'package:gdg_campus_coffee/menu/domain/use_case/get_products_use_case.dart';

class MenuViewModel extends ChangeNotifier {
  final _getProductsUseCase = GetProductsUseCase();

  bool loading = false;
  List<Product> products = [];
  String? error;

  Future<void> fetchProducts() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      products = await _getProductsUseCase();
    } catch (e) {
      error = e.toString();
      products = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
