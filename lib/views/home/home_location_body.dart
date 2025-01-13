import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/controllers/location_shared_preference_controller.dart';
import 'package:turbbbites_flutter_app/views/map/map_view.dart';

class HomeLocationBody extends StatefulWidget {
  const HomeLocationBody({super.key});

  @override
  State<HomeLocationBody> createState() => _HomeLocationBodyState();
}

class _HomeLocationBodyState extends State<HomeLocationBody> {
  LocationSharedPreferenceController controller =
      LocationSharedPreferenceController.controller;

  @override
  void initState() {
    super.initState();
    _getStoreLocation();
  }

  void _getStoreLocation() async {
    await controller.getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Current location"),
              IconButton(
                onPressed: () {
                  Get.toNamed('/map');
                },
                icon: Icon(Icons.edit_location_outlined),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, size: 16),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Location"),
                      SizedBox(
                        width: 8,
                      ),
                      Obx(() => controller.restaurantModel.value != null
                          ? Text(
                              "${controller.restaurantModel.value!.address}, ${controller.restaurantModel.value!.city}")
                          : Text("No location selected")),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
