class Reward {
  String companyName;
  final String backgroundImage;
  final String rewardOrigin;
  final String rewardOriginLogo;
  final String offer;
  final String logo;
  final String workingHours;

  Reward({
    this.companyName,
    this.backgroundImage,
    this.rewardOrigin,
    this.rewardOriginLogo,
    this.offer,
    this.logo,
    this.workingHours
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      companyName: json['company_name'],
      backgroundImage: json['background_image'],
      rewardOrigin: json['reward_origin'],
      rewardOriginLogo: json['reward_origin_logo'],
      offer: json['offer'],
      logo: json['logo'],
      workingHours: json['working_hours']
    );
  }
}
