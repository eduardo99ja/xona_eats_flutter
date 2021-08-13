import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xona_eats/src/models/category.dart';
import 'package:xona_eats/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:xona_eats/src/utils/my_colors.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key? key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductListController _con = ClientProductListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [_shoppingBag()],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menuDrawer(),
                SizedBox(height: 20),
                _textFieldSearch(),
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index) {
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category) {
            return Text('Hola');
          }).toList(),
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
              onTap: _con.goToUpdatePage,
              title: Text('Editar perfil'),
              trailing: Icon(Icons.edit_outlined),
            ),
            ListTile(
              title: Text('Mis pedidos'),
              trailing: Icon(Icons.shopping_cart_outlined),
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

  Widget _shoppingBag() {
    return GestureDetector(
      // onTap: _con.goToOrderCreatePage,
      onTap: () {},
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 13),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
              right: 16,
              top: 15,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _textFieldSearch() => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          // onChanged: _con.onChangeText,
          onChanged: null,
          decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
            hintStyle: TextStyle(fontSize: 17, color: Colors.grey[500]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );

  refresh() {
    setState(() {});
  }
}
