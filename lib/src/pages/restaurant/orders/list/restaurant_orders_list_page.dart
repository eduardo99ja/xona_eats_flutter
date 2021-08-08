import 'package:flutter/material.dart';

class RestaurantOrdersListPage extends StatefulWidget {
  const RestaurantOrdersListPage({Key? key}) : super(key: key);

  @override
  _RestaurantOrdersListPageState createState() =>
      _RestaurantOrdersListPageState();
}

class _RestaurantOrdersListPageState extends State<RestaurantOrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Delivery orders list'),
      ),
    );
  }
}
