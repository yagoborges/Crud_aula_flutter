import 'package:crud_flutter/contato.dart';
import 'package:flutter/material.dart';

class ContatoFormularioBack {
  late Contato contato;

  //diferenciar novo com alteração
  ContatoFormularioBack(BuildContext context){
    var parameter = ModalRoute.of(context)?.settings.arguments;
    if ((parameter == null)) {
      contato = Contato ();
    } else {
      contato = parameter as Contato;
    }
  }
}