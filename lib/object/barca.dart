import 'package:easy_skipper/object/image.dart';
import 'package:easy_skipper/object/motore.dart';
import 'package:easy_skipper/object/vela.dart';

class Barche {
  final double larghezza;
  final double lunghezza;
  final bool isMotor;
  final String nome;
  final CustomImage image;
  final Motore? motori;
  final Vela? vela;

  const Barche({
    required this.larghezza,
    required this.lunghezza,
    required this.isMotor,
    required this.nome,
    required this.image,
    required this.motori,
    required this.vela,
  });

  factory Barche.fromJson(Map<String, dynamic> json) {
    return Barche(
      larghezza: json["attributes"]['larghezza'] * 1.0,
      lunghezza: json["attributes"]['lunghezza'] * 1.0,
      isMotor: json["attributes"]['isMotor'],
      nome: json["attributes"]['nome_barca'],
      image: CustomImage.fromJson(json['attributes']['image']['data']['attributes']['formats']),
      motori: Motore.fromJson(json),
      vela: Vela.fromJson(json),
    );
  }
}
