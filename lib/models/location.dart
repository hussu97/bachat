class Location {
  final String address;
  final String city;
  final String formattedAddress;
  final double lat;
  final double lon;
  final String id;
  final String placeId;

  Location({
    this.address,
    this.city,
    this.formattedAddress,
    this.id,
    this.lat,
    this.lon,
    this.placeId
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'],
      formattedAddress: json['formatted_address'],
      city: json['city'],
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      placeId: json['place_id']
    );
  }
}
