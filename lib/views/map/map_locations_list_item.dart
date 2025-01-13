import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/restaurant_model.dart';

class MapLocationsListItem extends StatelessWidget {
  final RestaurantModel data;
  final Function(RestaurantModel) onSelect;
  final bool isSelected;
  const MapLocationsListItem(
      {super.key,
      required this.data,
      required this.onSelect,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.75,
      child: Card(
        margin: const EdgeInsets.only(right: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data.description != null
                  ? Text(
                      data.description!,
                    )
                  : Text(
                      "${data.address} ${data.city}",
                    ),
              SizedBox(height: 8),
              Text(
                "${data.postalCode} ${data.city}",
              ),
              SizedBox(height: 8),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isSelected
                      ? OutlinedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.check),
                          label: Text("Wybrany"),
                        )
                      : FilledButton.icon(
                          onPressed: () {
                            onSelect(data);
                          },
                          icon: Icon(Icons.add),
                          label: Text("Wybierz"),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
