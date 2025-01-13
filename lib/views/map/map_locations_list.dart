import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/restaurant_controller.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';
import 'package:turbbbites_flutter_app/views/map/map_locations_list_item.dart';

class MapLocationsList extends StatefulWidget {
  const MapLocationsList({super.key, required this.selected, required this.setStoreLocation});
  final Function(RestaurantModel) setStoreLocation;
  final RestaurantModel? selected;

  @override
  State<MapLocationsList> createState() => _MapLocationsListState();
}

class _MapLocationsListState extends State<MapLocationsList> {
  final RestaurantApiController controller = RestaurantApiController();
  List<RestaurantModel>? _restaurantsData;

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  void _fetchRestaurants() async {
    var response = await controller.getAllRestaurants();
    setState(() {
      _restaurantsData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _restaurantsData?.length ?? 0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        RestaurantModel current = _restaurantsData![index];
        bool isSelected = false;
        if(widget.selected != null) {
          isSelected = widget.selected!.id == current.id;
        }

        return MapLocationsListItem(
            data: current,
            isSelected: isSelected,
            onSelect: widget.setStoreLocation);
      },
    );
  }
}
