class Vela {
  final double altezza;

  const Vela({
    required this.altezza,
  });

  factory Vela.fromJson(Map<String, dynamic> json) {
    return json["data"][0]["attributes"]['Vela'] != null
        ? Vela(
            altezza: json["data"][0]["attributes"]['Vela']["altezza"],
          )
        : const Vela(altezza: 0);
  }
}
