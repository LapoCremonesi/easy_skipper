class CustomProfile {
  CustomProfile({
    required this.username,
    required this.UID,
    required this.isAgency,
    required this.isListView,
  });

  late String username;
  late String UID;
  late bool isAgency;
  late bool isListView;

  factory CustomProfile.fromJson(Map<String, dynamic> json) {
    return CustomProfile(
      username: json["data"][0]["attributes"]["username"],
      UID: json["data"][0]["attributes"]["UID"],
      isAgency: json["data"][0]["attributes"]["isAgency"],
      isListView: json["data"][0]["attributes"]["isListView"],
    );
  }
}
