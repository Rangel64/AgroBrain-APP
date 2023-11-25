import 'package:agrobrain/database/fazenda_database_helper.dart';
import 'package:flutter/material.dart';
import '../models/Fazendas.dart';
import 'fazendas_home.dart';

class UpdateFazenda extends StatefulWidget {
  Fazenda fazenda;
  final Function() refreshItems;
  UpdateFazenda({Key? key, required this.fazenda, required this.refreshItems})
      : super(key: key);

  @override
  _UpdateFazendaState createState() => _UpdateFazendaState(fazenda);
}

class _UpdateFazendaState extends State<UpdateFazenda> {
  String nomeFazenda = "";
  double area = 0;
  String proprietario = "";
  double latitude = 0;
  double longitude = 0;
  Fazenda fazendaAux;

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerArea = TextEditingController();
  TextEditingController _controllerProprietario = TextEditingController();
  TextEditingController _controllerLatitude = TextEditingController();
  TextEditingController _controllerLongitude = TextEditingController();

  _UpdateFazendaState(this.fazendaAux);

  @override
  void initState() {
    super.initState();
    nomeFazenda = _controllerNome.text = fazendaAux.nome;
    area = fazendaAux.area;
    _controllerArea.text = fazendaAux.area.toString();
    proprietario = _controllerProprietario.text = fazendaAux.proprietario;
    _controllerLatitude.text = fazendaAux.latitude.toString();
    latitude = fazendaAux.latitude;
    _controllerLongitude.text = fazendaAux.longitude.toString();
    longitude = fazendaAux.longitude;
    print(fazendaAux.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 40, 29),
      body: Center(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerNome,
                onChanged: (text) {
                  nomeFazenda = text;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Nome da Fazenda',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerArea,
                onChanged: (text) {
                  area = double.parse(text);
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Área da Fazenda',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerProprietario,
                onChanged: (text) {
                  proprietario = text;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Proprietario',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerLatitude,
                onChanged: (text) {
                  latitude = double.parse(text);
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Latitude',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controllerLongitude,
                onChanged: (text) {
                  longitude = double.parse(text);
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Longitude',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          updateFazenda();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 113, 200, 55),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          'Alterar Dados',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )))
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<void> updateFazenda() async {
    Fazenda fazenda = Fazenda(
        nome: nomeFazenda,
        area: area,
        proprietario: proprietario,
        latitude: latitude,
        longitude: longitude);

    fazenda.id = widget.fazenda.id;
    DataBaseFazendaHelper.instance.updateFazenda(fazenda);
    print("salvo");
    widget.refreshItems();
    var fazendas =
        await DataBaseFazendaHelper.instance.getAllFazendas() as List;
    if (fazendas != null) {
      fazendas.forEach((element) => print(element.id));
    } else {
      print("nenhuma fazenda encontrada");
    }

    Navigator.pushNamed(context, '/');
  }
}
