

import 'package:crud_flutter/contato_formulario.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  //This widget is the root of your application.
  static const HOME = '/';
  static const CONTATO_FORM = 'contato-form';
  static const CONTATO_LIST = 'contato-list';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contato ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        //HOME: (context) => MyContatoList(),
        CONTATO_FORM: (context) => ContatoFormulario(),
        HOME: (context) => ContatoFormulario(),
        //CONTATO_LIST: (context) => MyContatoList(),
      },
    );
  }
}





