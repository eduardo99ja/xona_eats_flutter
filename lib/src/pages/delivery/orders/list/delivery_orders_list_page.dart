import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xona_eats/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:xona_eats/src/utils/my_colors.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key? key}) : super(key: key);

  @override
  _DeliveryOrdersListPageState createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  DeliveryOrdersListController _con = DeliveryOrdersListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: Text(
          'Delivery',
        ),
      ),
    );
  }

  Widget _menuDrawer() => GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
          margin: EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/img/menu.png',
            width: 20.0,
            height: 20.0,
          ),
        ),
      );

  Widget _drawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60.0,
                    margin: EdgeInsets.only(top: 10.0),
                    child: FadeInImage(
                      image: (_con.user?.image != null)
                          ? NetworkImage(_con.user!.image!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider,
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Editar perfil'),
              trailing: Icon(Icons.edit_outlined),
            ),
            _con.user != null
                ? _con.user!.roles!.length > 1
                    ? ListTile(
                        title: Text('Seleccionar rol'),
                        trailing: Icon(Icons.person_outlined),
                        onTap: _con.goToRoles,
                      )
                    : Container()
                : Container(),
            ListTile(
              title: Text('Cerrar sesión'),
              trailing: Icon(Icons.power_settings_new),
              onTap: _con.logout,
            ),
          ],
        ),
      );

  refresh() {
    setState(() {});
  }
}
