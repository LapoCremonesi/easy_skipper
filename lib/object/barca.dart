import 'package:easy_skipper/object/motore.dart';
import 'package:easy_skipper/object/vela.dart';

class Barche {
  final double larghezza;
  final double lunghezza;
  final bool isMotor;
  final String nome;
  final Motore? motori;
  final Vela? vela;

  const Barche({
    required this.larghezza,
    required this.lunghezza,
    required this.isMotor,
    required this.nome,
    required this.motori,
    required this.vela,
  });

  factory Barche.fromJson(Map<String, dynamic> json) {
    return Barche(
      larghezza: json["attributes"]['larghezza'],
      lunghezza: json["attributes"]['lunghezza'],
      isMotor: json["attributes"]['isMotor'],
      nome: json["attributes"]['nome_barca'],
      motori: Motore.fromJson(json),
      vela: Vela.fromJson(json),
    );
  }
}
