import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';


class ClientAddressListController {

  late BuildContext context;
  late Function refresh;

  // List<Address> address = [];
  // AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref _sharedPref = new SharedPref();

  int radioValue = 0;

  bool? isCreated;

  Map<String, dynamic>? dataIsCreated;

  // OrdersProvider _ordersProvider = new OrdersProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    // _addressProvider.init(context, user);
    // _ordersProvider.init(context, user);

    refresh();
  }

  void createOrder() async {
    // Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    // List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    // Order order = new Order(
    //   idClient: user.id,
    //   idAddress: a.id,
    //   products: selectedProducts
    // );
    // ResponseApi responseApi = await _ordersProvider.create(order);
    Navigator.pushNamed(context, 'client/payments/create');
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    // _sharedPref.save('address', address[value]);

    refresh();
    print('Valor seleccioonado: $radioValue');
  }

  // Future<List<Address>> getAddress() async {
  //   address = await _addressProvider.getByUser(user.id);
  //
  //   Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
  //   int index = address.indexWhere((ad) => ad.id == a.id);
  //
  //   if (index != -1) {
  //     radioValue = index;
  //   }
  //   print('SE GUARDO LA DIRECCION: ${a.toJson()}');
  //
  //   return address;
  // }

  void goToNewAddress() async {
    var result = await Navigator.pushNamed(context, 'client/address/create');

    if (result != null) {
      if (result as bool) {
        refresh();
      }
    }
  }

}