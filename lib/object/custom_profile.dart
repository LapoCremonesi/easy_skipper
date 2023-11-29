class CustomProfile {
  CustomProfile({
    required this.username,
    required this.UID,
    required this.isAgency,
    required this.prenotazioni,
  });

  late String username;
  late String UID;
  late bool isAgency;
  late List prenotazioni;

  factory CustomProfile.fromJson(Map<String, dynamic> json) {
    return CustomProfile(
      username: json["username"],
      UID: json["UID"],
      isAgency: json["isAgency"],
      prenotazioni: json['Prenotazione'],
    );
  }
}
