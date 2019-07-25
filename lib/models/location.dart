class Location {
  final String city;
  final String formattedAddress;
  final double lat;
  final double lon;
  final String id;

  Location({
    this.city,
    this.formattedAddress,
    this.id,
    this.lat,
    this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      formattedAddress: json['formatted_address'],
      city: json['city'],
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
