// import 'package:bachat/models/location.dart';

// class Reward {
//   String companyName; //
//   final String backgroundImage; //
//   final String rewardOrigin; //
//   final String rewardOriginLogo; //
//   final String offer; //
//   final String logo; //
//   final String workingHours; //
//   String cost; //
//   final String termsAndConditions; //
//   final String expiryDate; //
//   final String link; //
//   String contact; //
//   final String rating; //
//   final String cuisine; //
//   final String offerDescription; //
//   final String offerType;
//   final String website;
//   final String id;
//   List<Location> locations;

//   Reward({
//     this.companyName,
//     this.backgroundImage,
//     this.rewardOrigin,
//     this.rewardOriginLogo,
//     this.offer,
//     this.logo,
//     this.workingHours,
//     this.contact,
//     this.cost,
//     this.cuisine,
//     this.expiryDate,
//     this.link,
//     this.offerDescription,
//     this.offerType,
//     this.rating,
//     this.termsAndConditions,
//     this.website,
//     this.id,
//     this.locations
//   });

//   factory Reward.fromJson(Map<String, dynamic> json) {
//     List<Location> l = new List();
//     json['locations'].forEach((location) => l.add(Location.fromJson(location)));
//     return Reward(
//       companyName: json['company_name'],
//       backgroundImage: json['background_image'],
//       rewardOrigin: json['reward_origin'],
//       rewardOriginLogo: json['reward_origin_logo'],
//       offer: json['offer'],
//       logo: json['logo'],
//       workingHours: json['working_hours'],
//       contact: json['contact'],
//       cost: json['cost'],
//       cuisine: json['cuisine'],
//       expiryDate: json['expiry_date'],
//       link: json['link'],
//       offerDescription: json['offer_description'],
//       offerType: json['offer_type'],
//       rating: json['rating'],
//       termsAndConditions: json['terms_and_conditions'],
//       website: json['website'],
//       id: json['id'],
//       locations: l
//     );
//   }
// }

// To parse this JSON data, do
//
//     final rewards = rewardsFromJson(jsonString);

// To parse this JSON data, do
//
//     final reward = rewardFromJson(jsonString);

import 'dart:convert';
import './location.dart';

Reward rewardFromJson(String str) => Reward.fromJson(json.decode(str));

String rewardToJson(Reward data) => json.encode(data.toJson());

class Reward {
    String backgroundImage;
    String companyName;
    String contact;
    String cost;
    String cuisine;
    String expiryDate;
    String id;
    String link;
    List<Location> locations;
    String logo;
    String offer;
    String offerDescription;
    String offerType;
    String rating;
    String rewardOrigin;
    String rewardOriginLogo;
    String termsAndConditions;
    String website;
    String workingHours;

    Reward({
        this.backgroundImage,
        this.companyName,
        this.contact,
        this.cost,
        this.cuisine,
        this.expiryDate,
        this.id,
        this.link,
        this.locations,
        this.logo,
        this.offer,
        this.offerDescription,
        this.offerType,
        this.rating,
        this.rewardOrigin,
        this.rewardOriginLogo,
        this.termsAndConditions,
        this.website,
        this.workingHours,
    });

    factory Reward.fromJson(Map<String, dynamic> json) => new Reward(
        backgroundImage: json["background_image"],
        companyName: json["company_name"],
        contact: json["contact"],
        cost: json["cost"],
        cuisine: json["cuisine"],
        expiryDate: json["expiry_date"],
        id: json["id"],
        link: json["link"],
        locations: json["locations"] == null ? null : new List<Location>.from(json["locations"].map((x) => x)),
        logo: json["logo"],
        offer: json["offer"],
        offerDescription: json["offer_description"],
        offerType: json["offer_type"],
        rating: json["rating"],
        rewardOrigin: json["reward_origin"],
        rewardOriginLogo: json["reward_origin_logo"],
        termsAndConditions: json["terms_and_conditions"],
        website: json["website"],
        workingHours: json["working_hours"],
    );

    Map<String, dynamic> toJson() => {
        "background_image": backgroundImage,
        "company_name": companyName,
        "contact": contact,
        "cost": cost,
        "cuisine": cuisine,
        "expiry_date": expiryDate,
        "id": id,
        "link": link,
        "locations": new List<dynamic>.from(locations.map((x) => x)),
        "logo": logo,
        "offer": offer,
        "offer_description": offerDescription,
        "offer_type": offerType,
        "rating": rating,
        "reward_origin": rewardOrigin,
        "reward_origin_logo": rewardOriginLogo,
        "terms_and_conditions": termsAndConditions,
        "website": website,
        "working_hours": workingHours,
    };
}
