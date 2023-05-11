

import 'package:crud_flutter/DatabaseHelper.dart';
import 'package:crud_flutter/contato_lista.dart';
import 'package:flutter/material.dart';

class ContatoFormulario extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  late String nome, email, idade;
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulário com Validação'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: _formUI(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    var _controller = TextEditingController();
    var _controller2 = TextEditingController();
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Nome Completo'),
            maxLength: 100,
            validator: _validarNome,
            onSaved: (String? val) {
              nome = val!;
            },
          ),
          TextFormField(
            controller: _controller2,
            decoration: InputDecoration(hintText: 'Idade'),
            keyboardType: TextInputType.number,
            maxLength: 3,
            validator: _validarIdade,
            onSaved: (String? val) {
              idade = val!;
            }),

        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _sendForm,
          child: Text('Enviar'),

          ),

        ElevatedButton(
          onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyContatoList())
           );
          },
          child: Text('Listar'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.clear();
            _controller2.clear();
          },
          child: Text('Limpar'))
      ],
    );
  }

  String? _validarNome(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String? _validarIdade(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Informe a idade";
    } else if (value.length != 2) {
      return "A idade deve ter até 2 dígitos";
    } else if (!regExp.hasMatch(value)) {
      return "A idade deve conter apenas números";
    }
    return null;
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }

  _sendForm() async {
    if (_key.currentState!.validate()) {
      //Sem erros na validação
      _key.currentState!.save();
      print("Nome $nome");
      print("Idade $idade");

      Map<String, dynamic> row = {
        DatabaseHelper.columnNome : nome,
        DatabaseHelper.columnIdade : idade,
      };
      final id = await dbHelper.insert(row);
      print('linha inserida id: $id');

    } else {
      // _validate = true;
      print('Erro de validação');
    }
  }
}