import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/category.dart';
import 'package:xona_eats/src/models/product.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/provider/categories_provider.dart';
import 'package:xona_eats/src/provider/products_provider.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class ClientProductListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  late Function refresh;
  User? user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  List<Category> categories = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user!);
    _productsProvider.init(context, user!);
    getCategories();
    refresh();
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
    // if (productName.isEmpty) {
    // }
    // else {
    //   return await _productsProvider.getByCategoryAndProductName(idCategory, productName);
    // }
  }

  logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
}
