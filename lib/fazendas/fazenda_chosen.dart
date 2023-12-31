import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../models/Fazendas.dart';
import '../piquetes/home_piquetes.dart';
import 'fazenda_settings.dart';

class ChosenFazenda extends StatefulWidget {
  Fazenda fazenda;
  final Function() refreshItems;
  ChosenFazenda({required this.fazenda, required this.refreshItems,Key? key}) : super(key: key);


  @override
  _ChosenFazendaState createState() => _ChosenFazendaState(fazenda: fazenda);
}

class _ChosenFazendaState extends State<ChosenFazenda> {
  Fazenda fazenda;
  Widget list = Container();

  homePiquetes() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePiquetes(fazenda:fazenda),
      ),
    );
  }

  fazendaSettings() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FazendaSettings(fazenda:fazenda,refreshItems:widget.refreshItems),
      ),
    );
  }

  _ChosenFazendaState({required this.fazenda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 40, 29),
      body: Center(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              constraints:const BoxConstraints.expand(),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 16, 40, 29)),
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [CircleAvatar()],
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                      child: Text(
                        fazenda.nome,
                        style: const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 215, 0, 100),
                      child: ListView(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: const Color.fromARGB(255, 53, 92, 22),
                            child: InkWell(
                              splashColor: Colors.greenAccent.withAlpha(30),
                              onTap: () {
                                homePiquetes();
                              },
                              child: SizedBox(
                                width: 300,
                                height: 150,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: const Text("Piquetes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: const Color.fromARGB(255, 53, 92, 22),
                            child: InkWell(
                              splashColor: Colors.greenAccent.withAlpha(30),
                              onTap: () {

                              },
                              child: SizedBox(
                                width: 300,
                                height: 150,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: const Text("Lotes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: const Color.fromARGB(255, 53, 92, 22),
                            child: InkWell(
                              splashColor: Colors.greenAccent.withAlpha(30),
                              onTap: () {

                              },
                              child: SizedBox(
                                width: 300,
                                height: 150,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: const Text("Gado",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          height: 60,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 29, 116, 74),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.map_marker,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),

                              const SizedBox(width: 25),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.document_info,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),

                              const SizedBox(width: 25),
                              IconButton(
                                onPressed: () {
                                  fazendaSettings();
                                },
                                icon: const Icon(
                                  UniconsLine.setting,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),

                              const SizedBox(width: 25),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.bell,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),

                              const SizedBox(width: 25),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.search,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}
