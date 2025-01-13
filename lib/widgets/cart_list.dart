import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/cart_model.dart';
import 'package:turbbbites_flutter_app/widgets/cart_list_item.dart';

class CartList extends StatelessWidget {
  final void Function(CartElementModel)? onRemove;
  final void Function(CartElementModel, int)? onQuantityChange;
  const CartList({super.key, required this.cart, this.onRemove, this.onQuantityChange});

  final List<CartElementModel> cart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var data in cart) CartListItem(data: data, onRemove: onRemove, onQuantityChange: onQuantityChange,),
      ],
    );
  }
}
