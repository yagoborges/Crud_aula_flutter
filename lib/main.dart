
import 'dart:convert';

import 'package:crud_flutter/contato.dart';
import 'package:crud_flutter/my_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var uriREST = Uri.parse('http://10.2.67.15:8080/contato');

void main() async {
  var contato = Contato(nome: 'Jobs', idade: '75');
  await salvar(contato);
  await buscar();

 runApp(MyApp());
}

Future<List<Contato>> buscar() async {

  var response = await http.get(uriREST);
  if(response.statusCode != 200)
    throw Exception('Erro de REST API.');

  Iterable listDart = json.decode(response.body);
  var listaContato = <Contato>[];

  for(Map<String, dynamic> item in listDart) {
    var contato = Contato(
      id: item['id'],
      nome: item['nome'],
      idade: item['idade']
    );

    listaContato.add(contato);
  }
  for(var c in listaContato) {
    print(c.nome);
  }
  return listaContato;
}

salvar(Contato contato) async {
  var headers = {
    'Content-Type':'application/json'
  };

  var statusCode = 0;
  var resposta;
  if(contato.id == null) {
    var contatoJson = jsonEncode({
      'nome': contato.nome,
      'idade': contato.idade
    });
    resposta = await http.post(uriREST, headers: headers, body: contatoJson);
  } else{
    var contatoJson = jsonEncode({
      'id': contato.id,
      'nome': contato.nome,
      'idade': contato.idade
    });
    resposta = await http.put(uriREST, headers: headers, body: contatoJson);
  }
  statusCode = resposta.statusCode;
  if(statusCode != 200)
    throw Exception('Erro de REST API');
}

excluir(int id) async {
  var uri = Uri.parse('http://10.2.67.15:8080/contato/$id');
  var resposta = await http.delete(uri);
  var statusCode = resposta.statusCode;
  if(statusCode != 200)
    throw Exception('Erro de REST API');
}



