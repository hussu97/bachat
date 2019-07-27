import 'package:bachat/models/location.dart';

class Reward {
  String companyName; //
  final String backgroundImage; //
  final String rewardOrigin; //
  final String rewardOriginLogo; //
  final String offer; //
  final String logo; //
  final String workingHours; //
  String cost; //
  final String termsAndConditions; //
  final String expiryDate; //
  final String link; //
  String contact; //
  final String rating; //
  final String cuisine; //
  final String offerDescription; //
  final String offerType;
  final String website;
  final String id;
  final List<Location> locations;

  Reward({
    this.companyName,
    this.backgroundImage,
    this.rewardOrigin,
    this.rewardOriginLogo,
    this.offer,
    this.logo,
    this.workingHours,
    this.contact,
    this.cost,
    this.cuisine,
    this.expiryDate,
    this.link,
    this.offerDescription,
    this.offerType,
    this.rating,
    this.termsAndConditions,
    this.website,
    this.id,
    this.locations
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    List<Location> l = new List();
    json['locations'].forEach((location) => l.add(Location.fromJson(location)));
    return Reward(
      companyName: json['company_name'],
      backgroundImage: json['background_image'],
      rewardOrigin: json['reward_origin'],
      rewardOriginLogo: json['reward_origin_logo'],
      offer: json['offer'],
      logo: json['logo'],
      workingHours: json['working_hours'],
      contact: json['contact'],
      cost: json['cost'],
      cuisine: json['cuisine'],
      expiryDate: json['expiry_date'],
      link: json['link'],
      offerDescription: json['offer_description'],
      offerType: json['offer_type'],
      rating: json['rating'],
      termsAndConditions: json['terms_and_conditions'],
      website: json['website'],
      id: json['id'],
      locations: l
    );
  }
}
