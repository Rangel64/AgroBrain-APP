import 'package:agrobrain/fazendas/fazenda_chosen.dart';
import 'package:agrobrain/fazendas/fazendas_insert.dart';
import 'package:agrobrain/models/Fazendas.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:unicons/unicons.dart';
import '../database/fazenda_database_helper.dart';

class HomeFazendas extends StatefulWidget {
  const HomeFazendas({Key? key}) : super(key: key);

  @override
  _HomeFazendasState createState() => _HomeFazendasState();
}

class _HomeFazendasState extends State<HomeFazendas> {
  Widget list = Container();
  Widget aux = Container();

  addFazenda(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsertFazenda(refreshItems: _loadItems),
      ),
    );
  }

  chosenFazenda(int id) async {
    Fazenda fazenda = await DataBaseFazendaHelper.instance.getFazendaById(id) as Fazenda;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChosenFazenda(fazenda: fazenda,refreshItems: _loadItems,),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    aux = await fazendasCards();
    setState((){
      list = aux;
    });
  }

  Future<Widget> fazendasCards() async {
    var fazendas = await DataBaseFazendaHelper.instance.getAllFazendas();
    return ListView.builder(
        itemCount: fazendas.length,
        itemBuilder: (context, index){
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            color: Color.fromARGB(255, 53, 92, 22),
            child: InkWell(
              splashColor: Colors.greenAccent.withAlpha(30),
              onTap: () {
                chosenFazenda(fazendas[index].id);
              },
              child: SizedBox(
                width: 300,
                height: 200,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(fazendas[index].nome,style: TextStyle(color:  Colors.white,fontSize: 25)),
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
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(color: Color.fromARGB(255, 16, 40, 29)),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Stack(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [CircleAvatar()],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 140, 0, 0),
                    child: Text("Olá, Rangel",style: TextStyle(color: Colors.white, fontSize: 40),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 215, 0, 85),
                    child: list,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        height: 60,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 29, 116, 74),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                UniconsLine.apps,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                UniconsLine.document_info,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {
                                addFazenda();
                              },
                              icon: Icon(
                                UniconsLine.plus_circle,
                                color: Color.fromARGB(255, 113, 200, 55),
                              ),
                              iconSize: 45,
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                UniconsLine.bell,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                UniconsLine.search,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        )
      ),
    );
  }
}
