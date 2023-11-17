
class Piquete{
  late int id;
  late int idFazenda;
  String nome;
  double area;
  double massaEstimada;

  Piquete({required this.idFazenda,required this.nome,required this.area,required this.massaEstimada});

  factory Piquete.fromMap(Map<String, dynamic> json) {
    Piquete piquete = Piquete(
        idFazenda: json["idFazenda"],
        nome: json["nome"],
        area: json["area"],
        massaEstimada: json["massaEstimada"]);
    piquete.id = json["id"];
    return piquete;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    "idFazenda": idFazenda,
    "nome": nome,
    "area": area,
    "massaEstimada": massaEstimada
  };
}
