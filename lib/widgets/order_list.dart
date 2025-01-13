import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/order_model.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final int total;
  const OrderList({super.key, required this.orders, required this.total});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        var order = orders[index];
        return Card(
          child: ListTile(
            title: Text("Order #${order.id % 10000}"),
            subtitle: Text("Total: ${order.totalPrice}"),
            trailing: Text("Status: ${order.status.name}"),
          ),
        );
      },
    );
  }
}
