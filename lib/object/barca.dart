import 'package:easy_skipper/object/motore.dart';
import 'package:easy_skipper/object/vela.dart';

class Barche {
  final double larghezza;
  final double lunghezza;
  final bool isMotor;
  final Motore? motori;
  final Vela? vela;

  const Barche({
    required this.larghezza,
    required this.lunghezza,
    required this.isMotor,
    required this.motori,
    required this.vela,
  });

  factory Barche.fromJson(Map<String, dynamic> json) {
    return Barche(
      larghezza: json["data"][0]["attributes"]['larghezza'],
      lunghezza: json["data"][0]["attributes"]['lunghezza'],
      isMotor: json["data"][0]["attributes"]['isMotor'],
      motori: Motore.fromJson(json),
      vela: Vela.fromJson(json),
    );
  }
}
