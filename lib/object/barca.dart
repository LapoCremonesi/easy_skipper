class Barche {
  final double larghezza;
  final double lunghezza;
  final bool isMotor;
  final String nome;
  final String image;
  final List motori;
  final Map vela;

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
      larghezza: json['larghezza'] * 1.0,
      lunghezza: json['lunghezza'] * 1.0,
      isMotor: json['isMotor'],
      nome: json['nome_barca'],
      image: json['image'],
      motori: json["Motore"],
      vela: json["Vela"],
    );
  }
}
