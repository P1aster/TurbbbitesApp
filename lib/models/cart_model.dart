import 'package:turbbbites_flutter_app/models/dish_model.dart';

class CartElementModel {
  final DishModel dish;
  int quantity;

  CartElementModel({required this.dish, required this.quantity});
}

class CartModel {
  int? _restaurantId;
  final List<CartElementModel> _cart = [];
  CartModel();

  int? get restaurantId {
    return _restaurantId;
  }

  List<CartElementModel> get cart {
    return _cart;
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cart) {
      total += element.dish.price * element.quantity;
    }
    return total;
  }

  int get totalItems {
    return _cart.length;
  }

  void addDish(CartElementModel cartElement) {
    var element = containsElement(cartElement.dish.id);
    if (element != null) {
      element.quantity += cartElement.quantity;
      return;
    }
    _cart.add(cartElement);
  }

  void removeDish(CartElementModel cartElement) {
    _cart.remove(cartElement);
  }

  CartElementModel? containsElement(int dishId) {
    for (var element in _cart) {
      if (element.dish.id == dishId) {
        return element;
      }
    }
    return null;
  }

  void clearCart() {
    _cart.clear();
  }

  void addDishByIndex(int index, CartElementModel element) {
    _cart.insert(index, element);
  }

  void setRestaurantId(int restaurantId) {
    _restaurantId = restaurantId;
  }

  void setRestaurantIdNull() {
    _restaurantId = null;
  }
  Map<String, dynamic> toJson() {
    return {
      'restaurantId': _restaurantId,
      'cart': _cart.map((e) => {
        'dishId': e.dish.id,
        'quantity': e.quantity,
      }).toList(),
    };
  }

}
