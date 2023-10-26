import 'package:easy_skipper/object/image.dart';
import 'package:easy_skipper/object/motore.dart';
import 'package:easy_skipper/object/vela.dart';

class Barche {
  final int id;
  final double larghezza;
  final double lunghezza;
  final bool isMotor;
  final String nome;
  final CustomImage image;
  final Motore? motori;
  final Vela? vela;

  const Barche({
    required this.id,
    required this.larghezza,
    required this.lunghezza,
    required this.isMotor,
    required this.nome,
    required this.image,
    required this.motori,
    required this.vela,
  });

  factory Barche.fromJson(Map<String, dynamic> json, int index) {
    return Barche(
      id: json['data'][index]['id'],
      larghezza: json['data'][index]["attributes"]['larghezza'] * 1.0,
      lunghezza: json['data'][index]["attributes"]['lunghezza'] * 1.0,
      isMotor: json['data'][index]["attributes"]['isMotor'],
      nome: json['data'][index]["attributes"]['nome_barca'],
      image: CustomImage.fromJson(json['data'][index]['attributes']['image']['data']['attributes']['formats']),
      motori: Motore.fromJson(json['data'][index]),
      vela: Vela.fromJson(json['data'][index]),
    );
  }
}
