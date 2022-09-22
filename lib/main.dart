import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp (
    home: const Home(),
    theme: ThemeData(
      hintColor: Colors.blue,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintStyle: TextStyle(color: Colors.lightBlueAccent))),
  ));
}

class Home extends StatefulWidget{
  const Home({Key? key}): super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();

  String _mensagem = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int ano = 0;
  int mes = 0;
  int dia = 0;

  _diaMesAnoParaDias(){
    setState(() {
      ano = int.parse(anoController.text);
      ano = int.parse(mesController.text);
      ano = int.parse(diaController.text);

      int dias = ano * 360 + mes * 30 + dia;

      _mensagem = "Você tem ${dias.toString()} dia(s)";
      anoController.clear();
      mesController.clear();
      diaController.clear();

    });
  }

  void _limpaCampos(){
    anoController.clear();
    mesController.clear();
    diaController.clear();
      setState(() {
        _mensagem = "Informe os seus dados";
        _formKey = GlobalKey<FormState>();
      });
  }

  Widget construirTextField(String texto, String prefixo, TextEditingController c, String mensagemErro){
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty){
          return mensagemErro;
        } else {
          return null;
        }
      },
    controller: c,
    decoration: InputDecoration(
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.blue),
      border: const OutlineInputBorder(),
      prefixText: prefixo),
    style: const TextStyle(
      color: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ano/Mês/Dia para Dias"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _limpaCampos, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.date_range,
                size: 150,
                color: Colors.blueAccent,
              ),
              construirTextField("Ano", "Ano:", anoController, "Erro"),
                const Divider(),
              construirTextField("Mês", "Mês:", mesController, "Erro"),
                const Divider(),
              construirTextField("Dia", "Dia:", diaController, "Erro"),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        _diaMesAnoParaDias();
                      }
                    },
                    child: const Text(
                      "Converter",
                      style: TextStyle(fontSize: 30, color: Colors.amber),
                    )),
                  ),
                Center(
                  child: Text(
                    _mensagem,
                    style:  const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30),
                  ),
                )
            ]
          ),),
        )
    );
  }
}
