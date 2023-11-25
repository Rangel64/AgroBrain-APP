import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../database/fazenda_database_helper.dart';
import '../models/Fazendas.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'fazendas_update.dart';

class FazendaSettings extends StatefulWidget {
  Fazenda fazenda;
  final Function() refreshItems;
  FazendaSettings({Key? key, required this.fazenda,required this.refreshItems}) : super(key: key);
  @override
  _FazendaSettingsState createState() => _FazendaSettingsState();
}

class _FazendaSettingsState extends State<FazendaSettings> {

  updateFazenda() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  UpdateFazenda(fazenda: widget.fazenda,refreshItems: widget.refreshItems,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 40, 29),
      body: Center(
          child: SizedBox(
        width: 400,
        height: 500,
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 217, 217, 217),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20,top: 100),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text("Nome: ${widget.fazenda.nome}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 23)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Área: ${double.parse((widget.fazenda.area).toStringAsFixed(2))} ha",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 23)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Latitude: ${double.parse((widget.fazenda.latitude).toStringAsFixed(2))}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Longitude: ${double.parse((widget.fazenda.longitude).toStringAsFixed(2))}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 23)),
                ]),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateFazenda();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.lightBlueAccent,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 15.0)
                          ],
                        ),
                        iconSize: 35,
                      ),
                      const SizedBox(width: 100),
                      IconButton(
                        onPressed: () {
                          deleteFazenda();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 15.0)
                          ],
                        ),
                        iconSize: 35,
                      ),
                    ],
                  ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> deleteFazenda() async {


    DataBaseFazendaHelper.instance.deleteFazenda(widget.fazenda.id);
    print("deleted");
    widget.refreshItems();
    var fazendas = await DataBaseFazendaHelper.instance.getAllFazendas() as List;
    if (fazendas != null) {
      fazendas.forEach((element) => print(element.id));
    } else {
      print("nenhuma fazenda encontrada");
    }

    Navigator.pushNamed(context, '/');
  }

}
