class Vela {
  final double altezza;

  const Vela({
    required this.altezza,
  });

  factory Vela.fromJson(Map<String, dynamic> json) {
    return json["attributes"]['Vela'] != null
        ? Vela(
            altezza: json["attributes"]['Vela']["altezza"] * 1.0,
          )
        : const Vela(altezza: 0.0);
  }
}
