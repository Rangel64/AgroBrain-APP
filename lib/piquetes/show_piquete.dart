import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:agrobrain/database/fazenda_database_helper.dart';
import 'package:agrobrain/models/Piquete.dart';
import 'package:agrobrain/piquetes/gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPiquete extends StatefulWidget{
  Piquete piquete;
  ShowPiquete({Key? key,required this.piquete}): super(key:key);
  @override
  _ShowPiqueteState createState() => _ShowPiqueteState();
}

class _ShowPiqueteState extends State<ShowPiquete>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 40, 29),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 500,
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Nome: ${widget.piquete.nome}",style: TextStyle(color:  Colors.black,fontSize: 23)),
                SizedBox(height: 20,),
                Text("Área: ${double.parse((widget.piquete.area).toStringAsFixed(2))} ha",style: TextStyle(color:  Colors.black,fontSize: 23)),
                SizedBox(height: 20,),
                Text("Massa Estimada: ${double.parse((widget.piquete.massaEstimada).toStringAsFixed(2))} kg/ha",style: TextStyle(color:  Colors.black,fontSize: 23)),
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 217, 217, 217),
              borderRadius: BorderRadius.circular(20)
            )
          ),
        )
      ),
    );
  }


  // double estimativaAnimal(double massa){
  //     double forragemDisponivelEConsumivel =  massa* 0.7 * 0.5;
  //
  //     double consumoDiario = 450 * 0.02;
  //     double quantidadeDeConsumoPorPeriodo = consumoDiario * dias;
  //     double capacidadeDeSuporte = forragemDisponivelEConsumivel / quantidadeDeConsumoPorPeriodo;
  //     return capacidadeDeSuporte;
  // }
}
