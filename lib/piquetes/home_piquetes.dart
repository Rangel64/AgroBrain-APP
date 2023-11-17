import 'package:agrobrain/models/Piquete.dart';
import 'package:agrobrain/piquetes/show_piquete.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../database/fazenda_database_helper.dart';
import '../models/Fazendas.dart';
import 'piquetes_insert.dart';

class HomePiquetes extends StatefulWidget {
  Fazenda fazenda;

  HomePiquetes({required this.fazenda,Key? key}) : super(key: key);

  @override
  _HomePiquetesState createState() => _HomePiquetesState(fazenda: fazenda);
}

class _HomePiquetesState extends State<HomePiquetes> {
  Widget list = Container();
  Widget aux = Container();
  Fazenda fazenda;


  _HomePiquetesState({required this.fazenda});

  void initState(){
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    aux = await piquetesCards();
    setState((){
      list = aux;
    });
  }

  addPiquete(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsertPiquete(fazenda: fazenda,refreshItems: _loadItems),
      ),
    );
  }

  showPiquete(Piquete piquete){
    Navigator.push(context,MaterialPageRoute(
        builder:(_) => ShowPiquete(piquete: piquete),
    ));
  }

  Future<Widget> piquetesCards() async {
    var piquetes = await DataBaseFazendaHelper.instance.getAllPiquetesByIdFazenda(fazenda.id);
    return ListView.builder(
        itemCount: piquetes.length,
        itemBuilder: (context, index){
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            color: Color.fromARGB(255, 217, 217, 217),
            child: InkWell(
              splashColor: Colors.greenAccent.withAlpha(30),
              onTap: () {
                showPiquete(piquetes[index]);
              },
              child: SizedBox(
                width: 270,
                height: 90,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text("Piquete: ${piquetes[index].nome}",style: TextStyle(color:  Colors.black,fontSize: 25)),
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              constraints: const BoxConstraints.expand(),
              decoration:
              const BoxDecoration(color: Color.fromARGB(255, 16, 40, 29)),
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [CircleAvatar()],
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 215, 0, 100),
                      child: list,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // alignment: AlignmentDirectional.centerEnd,
                          height: 60,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 29, 116, 74),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.apps,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),
                              SizedBox(width: 15),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.document_info,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),
                              SizedBox(width: 15),
                              IconButton(
                                onPressed: () {
                                  addPiquete();
                                },
                                icon: const Icon(
                                  UniconsLine.plus_circle,
                                  color: Color.fromARGB(255, 113, 200, 55),
                                ),
                                iconSize: 45,
                              ),
                              SizedBox(width: 15),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  UniconsLine.bell,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),
                              SizedBox(width: 15),
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
