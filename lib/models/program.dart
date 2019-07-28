class RewardsProgram {
  final String slug;
  final String description;
  final String webLink;
  final String appStoreLink;
  final String playStoreLink;

  RewardsProgram({
    this.slug,
    this.description,
    this.webLink,
    this.appStoreLink,
    this.playStoreLink,
  });

  factory RewardsProgram.fromJson(Map<String, dynamic> json) {
    return RewardsProgram(
      slug: json['slug'],
      description: json['description'],
      webLink: json['reward_origin_link'],
      appStoreLink: json['app_store_link'],
      playStoreLink: json['play_store_link']
    );
  }
}