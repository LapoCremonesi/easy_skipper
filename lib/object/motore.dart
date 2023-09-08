class Motore {
  final int cavalli;
  final String marca;

  const Motore({
    required this.cavalli,
    required this.marca,
  });

  factory Motore.fromJson(Map<String, dynamic> json) {
    return json["data"][0]["attributes"]["Motore"].length != 0
        ? Motore(
            cavalli: json["data"][0]["attributes"]["Motore"][0]["cavalli"],
            marca: json["data"][0]["attributes"]["Motore"][0]["marca"],
          )
        : const Motore(cavalli: 0, marca: "");
  }
}
