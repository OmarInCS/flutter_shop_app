import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  favorites, all
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                }
                else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Only Favorites"), value: FilterOptions.favorites,),
              PopupMenuItem(child: Text("Show All"), value: FilterOptions.all,),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
              value: cart.itemCount.toString(),
            ),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
      drawer: AppDrawer(),
    );
  }
}
