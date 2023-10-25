class CustomImage {
  String? thumbnail = '';
  String? small = '';
  String? medium = '';

  CustomImage({
    this.thumbnail,
    this.small,
    this.medium,
  });

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      thumbnail: json['thumbnail']['url'] ?? '',
      small: json['small']['url'] ?? '',
      medium: json['medium'] == null ? '' : json['medium']['url'],
    );
  }
}
