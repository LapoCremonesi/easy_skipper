class CustomAgency {
  CustomAgency({
    required this.indirizzo,
    required this.nome,
    required this.telefono,
    required this.UID,
    required this.servizi,
  });

  late String indirizzo;
  late String nome;
  late String telefono;
  late String UID;
  late List servizi;

  factory CustomAgency.fromJson(Map<String, dynamic> json) {
    return CustomAgency(
      indirizzo: json["attributes"]["indirizzo"],
      nome: json["attributes"]["nome"],
      telefono: json["attributes"]["telefono"],
      UID: json["attributes"]["UID"],
      servizi: json["attributes"]['Servizi'],
    );
  }
}
