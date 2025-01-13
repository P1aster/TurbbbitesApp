import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/models/cart_model.dart';

class CartController extends GetxController {
  static CartController get controller => Get.find<CartController>();
  Rx<CartModel> cart = Rx(CartModel());

  int get listCount => cart.value.totalItems;

  int? get restaurantId => cart.value.restaurantId;

  void setRestaurantId(int id) {
    cart.value.setRestaurantId(id);
    cart.refresh();
  }

  void addToCart(CartElementModel element) {
    cart.value.addDish(element);
    cart.refresh();
  }

  void removeFromCart(CartElementModel element) {
    cart.value.removeDish(element);
    cart.refresh();
  }

  void changeQuantity(CartElementModel element, int quantity) {
    var elementInCart = cart.value.containsElement(element.dish.id);
    if (elementInCart != null) {
      elementInCart.quantity = quantity;
      cart.refresh();
    }
  }


  void clearCart() {
    cart.value.clearCart();
    cart.refresh();
  }
}
