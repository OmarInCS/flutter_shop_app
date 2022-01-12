
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Order;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders"
        ),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, i) => OrderItem(order: orderData.orders[i],),
      ),
      drawer: AppDrawer(),
    );
  }
}
