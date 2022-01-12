
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as pr;

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final pr.OrderItem order;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
                "\$${widget.order.amount}"
            ),
            subtitle: Text(
                DateFormat("MMM, dd YYYY hh:mm").format(widget.order.dateTime)
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              height: min(widget.order.products.length * 20 + 40, 180),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) {
                  final product = widget.order.products[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "${product.quantity} X \$${product.price}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey
                        ),
                      )
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
