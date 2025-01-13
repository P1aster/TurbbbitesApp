class RestaurantModel {
  final int id;
  final String address;
  final String postalCode;
  final String city;
  final DateTime registrationDate;
  final String? description;
  final String? contactInformation;

  RestaurantModel({
    required this.id,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.registrationDate,
    this.description,
    this.contactInformation,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      address: json['address'],
      postalCode: json['postalCode'],
      city: json['city'],
      registrationDate: DateTime.parse(json['registrationDate']),
      description: json['description'],
      contactInformation: json['contactInformation'],
    );
  }
}
