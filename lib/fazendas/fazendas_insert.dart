import 'package:agrobrain/database/fazenda_database_helper.dart';
import 'package:flutter/material.dart';
import '../models/Fazendas.dart';

class InsertFazenda extends StatefulWidget {
  final Function() refreshItems;
  const InsertFazenda({Key? key, required this.refreshItems}) : super(key: key);

  @override
  _InsertFazendaState createState() => _InsertFazendaState(refreshItems: refreshItems);
}

class _InsertFazendaState extends State<InsertFazenda> {
  String nomeFazenda = "";
  double area = 0;
  String proprietario = "";
  double latitude = 0;
  double longitude = 0;
  late Fazenda fazenda;
  final Function() refreshItems;

  _InsertFazendaState({required this.refreshItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 16, 40, 29),
        body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextField(
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
                                insertFazenda();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Color.fromARGB(255, 113, 200, 55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Text(
                                'Salvar',
                                style: TextStyle(color: Colors.black,fontSize: 18),
                              )
                          )
                      )
                    ],
                  )
                ],
              ),
            )
        ),
    );
  }
  Future<void> insertFazenda() async {
    fazenda = new Fazenda(nome: nomeFazenda, area: area, proprietario: proprietario, latitude: latitude, longitude: longitude);
    DataBaseFazendaHelper.instance.insertFazenda(fazenda);
    await refreshItems();
    print("salvo");
    var fazendas = await DataBaseFazendaHelper.instance.getAllFazendas() as List;
    if(fazendas!=null){
      fazendas.forEach((element) => print(element.id));
    }
    else{
      print("nenhuma fazenda encontrada");
    }
  }
}
