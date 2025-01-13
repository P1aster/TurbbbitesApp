import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/order_controller.dart';
import 'package:turbbbites_flutter_app/models/order_model.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';
import 'package:turbbbites_flutter_app/widgets/order_list.dart';

class UserLogged extends StatefulWidget {
  const UserLogged({super.key});

  @override
  State<UserLogged> createState() => _UserLoggedViewState();
}

class _UserLoggedViewState extends State<UserLogged> {

  OrderApiController orderController = OrderApiController.controller;
  PaginationResponseModel<OrderModel>? _orders;

  _fetchOrders() async {
    var response = await orderController.getAllOrders();
    setState(() {
      _orders = response;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Orders"),
            SizedBox(height: 16,),
            Expanded(
              child: Obx(() {
                if (orderController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (orderController.isError.value) {
                  return Center(child: Text(orderController.error.value));
                }
                if (_orders == null || _orders!.data.isEmpty) {
                  return Center(child: Text("No orders"));
                }
                return OrderList(orders: _orders!.data, total: _orders!.total);
              }),
            ),

          ],
        ),
      ),
    );
  }
}
