import 'package:flutter/material.dart';
import 'result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _sexoSelecionado = 'homem';

  void _resetCampos() {
    pesoController = TextEditingController();
    alturaController = TextEditingController();
    _formKey.currentState!.reset();
  }

  void _handleSexoSelecionado(String sexo) {
    setState(() {
      _sexoSelecionado = sexo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.lightBlue),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value!.isEmpty) return "Insira seu peso!";
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value!.isEmpty) return "Insira sua altura!";
                  return null;
                },
              ),
              ListTile(
                title: Text("Sexo:"),
                subtitle: Row(
                  children: <Widget>[
                    Radio(
                      value: 'homem',
                      groupValue: _sexoSelecionado,
                      onChanged: (String? value) {
                        _handleSexoSelecionado(value!);
                      },
                    ),
                    Text('Homem'),
                    Radio(
                      value: 'mulher',
                      groupValue: _sexoSelecionado,
                      onChanged: (String? value) {
                        _handleSexoSelecionado(value!);
                      },
                    ),
                    Text('Mulher'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcular() {
    String _texto = "";
    String _imagem = "";

    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    if (_sexoSelecionado == 'homem') {
      if (imc < 18.6) {
        _texto = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_magro.png";
      } else if (imc >= 18.6 && imc < 24.9) {
        _texto = "Peso ideal (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_ideal.png";
      } else if (imc >= 24.9 && imc < 29.9) {
        _texto = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_obesa.png";
      } else if (imc >= 29.9 && imc < 34.9) {
        _texto = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_obesa.png";
      } else if (imc >= 34.9 && imc < 39.9) {
        _texto = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_obesa.png";
      } else if (imc >= 40) {
        _texto = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/homem_obesa.png";
      }
    } else if (_sexoSelecionado == 'mulher') {
      if (imc < 18.5) {
        _texto = "Mulher Abaixo do peso (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_magra.png";
      } else if (imc >= 18.5 && imc < 24.9) {
        _texto = "Mulher Peso ideal (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_ideal.png";
      } else if (imc >= 24.9 && imc < 29.9) {
        _texto =
            "Mulher Levemente acima do peso (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_obesa.png";
      } else if (imc >= 29.9 && imc < 34.9) {
        _texto = "Mulher Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_obesa.png";
      } else if (imc >= 34.9 && imc < 39.9) {
        _texto = "Mulher Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_obesa.png";
      } else if (imc >= 40) {
        _texto = "Mulher Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        _imagem = "imagens/mulher_obesa.png";
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(_imagem, _texto)),
    );
  }
}
