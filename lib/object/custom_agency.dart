import 'package:easy_skipper/object/image.dart';

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
  late CustomImage image;
  late List servizi;
  late List prenotazioni;

  factory CustomAgency.fromJson(Map<String, dynamic> json, bool isNull) {
    if (isNull) {
      return CustomAgency(
        indirizzo: '',
        nome: '',
        telefono: '',
        UID: '',
        image: CustomImage(),
        servizi: [],
        prenotazioni: [],
      );
    }

    return CustomAgency(
      indirizzo: json["attributes"]["indirizzo"],
      nome: json["attributes"]["nome"],
      telefono: json["attributes"]["telefono"],
      UID: json["attributes"]["UID"],
      image: CustomImage.fromJson(json['attributes']['image']['data']['attributes']['formats']),
      servizi: json["attributes"]['Servizi'],
      prenotazioni: json['attributes']['Prenotazione'],
    );
  }
}
