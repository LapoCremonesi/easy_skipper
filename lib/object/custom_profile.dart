class CustomProfile {
  CustomProfile({
    required this.username,
    required this.UID,
    required this.id,
    required this.isAgency,
    required this.prenotazioni,
  });

  late String username;
  late String UID;
  late int id;
  late bool isAgency;
  late List prenotazioni;

  factory CustomProfile.fromJson(Map<String, dynamic> json) {
    return CustomProfile(
      username: json["data"][0]["attributes"]["username"],
      UID: json["data"][0]["attributes"]["UID"],
      id: json["data"][0]["id"],
      isAgency: json["data"][0]["attributes"]["isAgency"],
      prenotazioni: json['data'][0]['attributes']['Prenotazione'],
    );
  }
}
