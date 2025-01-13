import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/dish_category_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/dish_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/order_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/restaurant_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/core/controllers/location_shared_preference_controller.dart';
import 'package:turbbbites_flutter_app/views/auth/log_in_view.dart';
import 'package:turbbbites_flutter_app/views/auth/register_view.dart';
import 'package:turbbbites_flutter_app/views/cart/cart_view.dart';
import 'package:turbbbites_flutter_app/views/dish/dish_view.dart';
import 'package:turbbbites_flutter_app/views/home/home_view.dart';
import 'package:turbbbites_flutter_app/views/map/map_view.dart';
import 'package:turbbbites_flutter_app/views/orders/orders_view.dart';
import 'package:turbbbites_flutter_app/views/settings/settings_view.dart';
import 'package:turbbbites_flutter_app/views/unknown/unknown_page_view.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF07B261),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF07B261),
);

void main() {

  Get.put(LocationSharedPreferenceController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(OrderApiController(), permanent: true);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Turbbbites',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
      ),
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownPageView()),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => const HomeView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthApiController());
              Get.lazyPut(() => DishCategoryApiController());
              Get.lazyPut(() => DishApiController());
              Get.lazyPut(() => OrderApiController());
            })),
        GetPage(
            name: '/auth/login',
            page: () => const LogInView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthApiController());
            })),
        GetPage(
            name: '/auth/register',
            page: () => const RegisterView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthApiController());
            })),
        GetPage(
            name: '/map',
            page: () => MapView(dish: Get.arguments),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => RestaurantApiController());
              // Get.lazyPut(() => LocationSharedPreferenceController());
            })),
        GetPage(
            name: '/dish',
            page: () => DishView(dish: Get.arguments),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => DishApiController());
              // Get.lazyPut(() => CartController());

            })),
        GetPage(
            name: '/cart',
            page: () => CartView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => OrderApiController());
            })),
        GetPage(name: '/settings', page: () => SettingsView()),
        GetPage(
            name: '/orders',
            page: () => OrdersView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => OrderApiController());
            })),
      ],
    );
  }
}
