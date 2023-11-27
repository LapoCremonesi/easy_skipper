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
      id: json[index]['id'],
      larghezza: json[index]["attributes"]['larghezza'] * 1.0,
      lunghezza: json[index]["attributes"]['lunghezza'] * 1.0,
      isMotor: json[index]["attributes"]['isMotor'],
      nome: json[index]["attributes"]['nome_barca'],
      image: CustomImage.fromJson(json[index]['attributes']['image']['attributes']['formats']),
      motori: Motore.fromJson(json[index]),
      vela: Vela.fromJson(json[index]),
    );
  }
}
