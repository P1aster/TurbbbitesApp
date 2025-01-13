import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/cart_model.dart';
import 'package:turbbbites_flutter_app/widgets/quantity_input.dart';

class CartListItem extends StatelessWidget {
  final CartElementModel data;
  final void Function(CartElementModel)? onRemove;
  final void Function(CartElementModel, int)? onQuantityChange;
  const CartListItem({super.key, required this.data, this.onRemove, this.onQuantityChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.dish.name),
                    Text(data.dish.price.toStringAsFixed(2)),
                  ],
                ),
                if(onRemove != null && onQuantityChange != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          onRemove!(data);
                        },
                        icon: Icon(Icons.delete_outline_rounded),
                      ),
                      QuantityInput(
                        initVal: data.quantity,
                        minVal: 1,
                        maxVal: 10,
                        onChanged: (value) {
                          onQuantityChange!(data, value);
                        },
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
