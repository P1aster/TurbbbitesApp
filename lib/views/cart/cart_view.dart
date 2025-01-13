import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/order_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/widgets/cart_list.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = CartController.controller;
  OrderApiController orderController = OrderApiController.controller;
  AuthApiController authApiController = AuthApiController.controller;

  void _onSubmit() async {
    if(authApiController.authModel.value == null) {
      Get.toNamed("/auth/login");
      return;
    }
    var response = await orderController.addOrder(cartController.cart.value);
    if(response != null) {
      cartController.clearCart();
      Get.back();
    } else {
      Get.snackbar("Error", orderController.error.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          IconButton(
            onPressed: () {
              cartController.clearCart();
            },
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ${cartController.cart.value.totalPrice.toStringAsFixed(2)}"),
                Obx(() => FilledButton.icon(
                  onPressed: (cartController.listCount > 0 || orderController.isLoading.value) ?
                      _onSubmit : null,
                  icon: Icon(Icons.arrow_right),
                  iconAlignment: IconAlignment.end,
                  label: Text("Order"),
                ),),
              ],
            ),
          ),
        ),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (cartController.cart.value.cart.isEmpty) {
            return Center(child: Text("No items in cart"));
          }
          return CartList(cart: cartController.cart.value.cart, onRemove: cartController.removeFromCart, onQuantityChange: cartController.changeQuantity);
        },
      ),
      )
    );
  }
}
