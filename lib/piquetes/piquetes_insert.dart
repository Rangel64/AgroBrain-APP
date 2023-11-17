import 'dart:io';
import 'dart:math';
import 'package:agrobrain/database/fazenda_database_helper.dart';
import 'package:agrobrain/models/Piquete.dart';
import 'package:agrobrain/piquetes/gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/Fazendas.dart';

class InsertPiquete extends StatefulWidget {

  final Function() refreshItems;
  Fazenda fazenda;
  InsertPiquete({required this.fazenda,required this.refreshItems,Key? key}) : super(key: key);

  @override
  _InsertPiqueteState createState() => _InsertPiqueteState(fazenda: fazenda,refreshItems: refreshItems);
}

class _InsertPiqueteState extends State<InsertPiquete> {
  String mass = "";
  String massMean = "";
  ImagePicker imagePicker = ImagePicker();
  String url = 'https://flask-teste-production.up.railway.app/';
  double? serverLoad = 0;
  double numeroDeDias = 0;
  String massaEstimada = '';
  double capacidadeDeSuporte = 0;
  List imagens = [];
  double somaDeMassas = 0;
  double mediaDaMassa = 0;
  //double dias = 0;
  //String dias_aux = '';
  final Function() refreshItems;
  String nome="";
  double area = 0;
  String area_aux = "";
  Fazenda fazenda;
  _InsertPiqueteState({required this.fazenda,required this.refreshItems});

  mostrarImagens(){
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => Gallery(imagens: imagens),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 40, 29),
      body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (text) {
                      nome = text;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nome do piquete',
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
                      area_aux = text;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Área em hectares',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Adicionar imagens para estimativa",style: TextStyle(color:  Colors.white,fontSize: 18))]
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){
                        pegarImagemGaleria();
                        // estimativaAnimal();
                      },
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      color: Colors.white,),
                    IconButton(
                      onPressed: (){
                        pegarImagemCamera();
                        // estimativaAnimal();
                      },
                      icon: const Icon(Icons.photo_camera_outlined),
                      color: Colors.white,),

                    IconButton(
                      onPressed: (){
                        mostrarImagens();
                      },
                      icon: const Icon(Icons.browse_gallery_outlined),
                      color: Colors.white,)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              estimativaDeMassa();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromARGB(255, 113, 200, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              'Calcular',
                              style: TextStyle(color: Colors.black,fontSize: 18),
                            )
                        )
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      value: serverLoad,
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(mass,style: TextStyle(color:  Colors.white))]
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(massMean,style: TextStyle(color:  Colors.white),textAlign: TextAlign.center)]
                ),

                const SizedBox(
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
                              salvar();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color.fromARGB(255, 113, 200, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              'Salvar',
                              style: TextStyle(color: Colors.black,fontSize: 18),
                            )
                        )
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  pegarImagemGaleria() async {
    final XFile? imagemTemporaria =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (imagemTemporaria != null) {
      imagens.add(File(imagemTemporaria.path));

    }
  }

  pegarImagemCamera() async {
    final XFile? imagemTemporaria = await imagePicker.pickImage(
        source: ImageSource.camera);

    if (imagemTemporaria != null) {
      imagens.add(File(imagemTemporaria.path));
    }
  }

  estimativaDeMassa() async {
    if(area_aux == ''){
      setState(() {
        mass = 'Informe a área  diferente de 0ha.';
      });
    }
    else{
      area = double.parse(area_aux);
      if(area == 0){
        setState(() {
          mass = 'Área igual a 0ha.';
        });
      }
      else{
        if(imagens.isEmpty){
          setState(() {
            mass = 'Não há imagens adicionadas.';
          });
        }
        else{
          var bytes;

          setState(() {
            mass = '';
            massMean = '';
          });

          setState(() {
            serverLoad = null;
          });

          for(int i = 0;i<imagens.length;i++){
            bytes = await imagens[i].readAsBytes();
            String base64Encode = base64.encode(bytes);

            final response = await http.post(Uri.parse(url),
                body: json.encode({'image': base64Encode}));

            final decoded = json.decode(response.body) as Map<String, dynamic>;

            massaEstimada = decoded['response'];

            massaEstimada = decoded['response'];
            somaDeMassas = somaDeMassas +  double.parse(massaEstimada);
          }

          mediaDaMassa = (somaDeMassas/imagens.length)*area;
          // estimativaAnimal();

          setState(() {
            massMean = 'Massa Média estimada \npara a área informada:${mediaDaMassa.toStringAsFixed(2)}kg/ha';
            mass = 'Estimativa para 1ha: ${(somaDeMassas/imagens.length).toStringAsFixed(2)}kg/ha';
            serverLoad = 0;
          });

          imagens.clear();
          somaDeMassas = 0;
        }
      }
    }
  }

  Future<void> salvar() async {
    if(nome==""){
      Fluttertoast.showToast(
          msg: "Nome do piquete nao informado.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
    else if(area_aux==""){
      Fluttertoast.showToast(
          msg: "Área nao informada.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
    else if(mediaDaMassa==0){
      Fluttertoast.showToast(
          msg: "A massa de forragem precisa ser estimada.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
    else{
      Piquete piquete = Piquete(idFazenda: fazenda.id, nome: nome, area: area, massaEstimada: mediaDaMassa);
      DataBaseFazendaHelper.instance.insertPiquete(piquete);

      Fluttertoast.showToast(
          msg: "A piquete salvo com sucesso!.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );

      List<Piquete> list = await DataBaseFazendaHelper.instance.getAllPiquetesByIdFazenda(fazenda.id) as List<Piquete>;
      refreshItems();

      if(list!=null){
        list.forEach((element) => print(element.id));
      }
      else{
        print("nenhuma fazenda encontrada");
      }
    }
  }

  // void estimativaAnimal(){
  //   if (mediaDaMassa != 0) {
  //     setState(() {
  //       serverLoad = 0;
  //     });
  //   }
  //   double forragemDisponivelEConsumivel = mediaDaMassa * 0.7 * 0.5;
  //
  //   double consumoDiario = 450 * 0.02;
  //   double quantidadeDeConsumoPorPeriodo = consumoDiario * dias;
  //   capacidadeDeSuporte = forragemDisponivelEConsumivel / quantidadeDeConsumoPorPeriodo;
  // }
}
