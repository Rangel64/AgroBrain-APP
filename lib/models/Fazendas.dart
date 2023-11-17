
class Fazenda{
  late int id;
  String nome;
  double area;
  String proprietario;
  double latitude;
  double longitude;

  Fazenda({required this.nome,required this.area,required this.proprietario,required this.latitude,required this.longitude});

  factory Fazenda.fromMap(Map<String, dynamic> json) {
    Fazenda fazenda = Fazenda(
        nome: json["nome"],
        area: json["area"],
        proprietario: json["proprietario"],
        latitude: json["latitude"],
        longitude: json["longitude"]);
    fazenda.id = json["id"];
    return fazenda;
  }



  Map<String, dynamic> toMap() => <String, dynamic>{
    "nome": nome,
    "area": area,
    "proprietario": proprietario,
    "latitude": latitude,
    "longitude": longitude,
  };
}