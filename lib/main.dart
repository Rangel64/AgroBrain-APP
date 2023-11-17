import 'package:agrobrain/fazendas/fazendas_home.dart';
import 'package:flutter/material.dart';

void main()async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeFazendas(),
    );
  }
}
