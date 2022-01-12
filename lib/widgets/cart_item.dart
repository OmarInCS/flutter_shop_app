
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' as pr;
import 'package:shop_app/providers/cart.dart' show Cart;

class CartItem extends StatelessWidget {
  final pr.CartItem cartItem;
  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => cart.removeItem(cartItem.productId),
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (context) => AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you want to remove the item from the cart?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),

          ],
        ),);
      },
      background: Container(
        color: Theme.of(context).errorColor.withAlpha(95),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(child: Text("\$${cartItem.price}")),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text("Total: \$${cartItem.quantity * cartItem.price}"),
            trailing: Text("${cartItem.quantity} X"),
          ),
        ),
      ),
    );
  }
}
