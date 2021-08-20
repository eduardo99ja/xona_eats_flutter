import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xona_eats/src/models/order.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/provider/orders_provider.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class RestaurantOrdersListController {
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;
  User? user;

  List<String> status = ['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();

  bool? isUpdated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context, user!);
    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await _ordersProvider.getByStatus(status);
  }

  void openBottomSheet(Order order) async {
    // isUpdated = await showMaterialModalBottomSheet(
    //     context: context, builder: (context) => RestaurantOrdersDetailPage(order: order));
    //
    // if (isUpdated as bool) {
    //   refresh();
    // }
  }

  void logout() {
    _sharedPref.logout(context, user!.id!);
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
