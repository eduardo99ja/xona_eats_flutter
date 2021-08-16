import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xona_eats/src/pages/client/products/detail/client_products_detail_controller.dart';

class ClientProductsDetailPage extends StatefulWidget {
  const ClientProductsDetailPage({Key? key}) : super(key: key);

  @override
  _ClientProductsDetailPageState createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      child: Text('Modal sheet'),
    );
  }

  void refresh() {
    setState(() {});
  }
}
