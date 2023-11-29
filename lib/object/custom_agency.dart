class CustomAgency {
  CustomAgency({
    required this.indirizzo,
    required this.nome,
    required this.telefono,
    required this.UID,
    required this.image,
    required this.servizi,
    required this.prenotazioni,
  });

  late String indirizzo;
  late String nome;
  late String telefono;
  late String UID;
  late String image;
  late List servizi;
  late List prenotazioni;

  factory CustomAgency.fromJson(Map<String, dynamic> json) {
    return CustomAgency(
      indirizzo: json["indirizzo"],
      nome: json["nome"],
      telefono: json["telefono"],
      UID: json["UID"],
      image: json['image'],
      servizi: json['Servizi'],
      prenotazioni: json['Prenotazione'],
    );
  }
}
