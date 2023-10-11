class CustomAgency {
  CustomAgency({
    required this.indirizzo,
    required this.nome,
    required this.telefono,
    required this.UID,
    required this.mediumImage,
    required this.thumbnailImage,
    required this.servizi,
  });

  late String indirizzo;
  late String nome;
  late String telefono;
  late String UID;
  late String thumbnailImage;
  late String mediumImage;
  late List servizi;

  factory CustomAgency.fromJson(Map<String, dynamic> json, bool isNull) {
    if (isNull) {
      return CustomAgency(
        indirizzo: '',
        nome: '',
        telefono: '',
        UID: '',
        mediumImage: '',
        thumbnailImage: '',
        servizi: [],
      );
    }

    return CustomAgency(
      indirizzo: json["attributes"]["indirizzo"],
      nome: json["attributes"]["nome"],
      telefono: json["attributes"]["telefono"],
      UID: json["attributes"]["UID"],
      thumbnailImage: json["attributes"]['image']['data']['attributes']
          ['formats']['thumbnail']['url'],
      mediumImage: json["attributes"]['image']['data']['attributes']['formats']
          ['medium']['url'],
      servizi: json["attributes"]['Servizi'],
    );
  }
}
