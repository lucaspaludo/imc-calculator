import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController highController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infoText = "Informe Seus Dados";

  void _resetField(){
    weightController.text = "";
    highController.text = "";
    setState(() {
      _infoText = "Informe Seus Dados";
    });
  }

  void _calculate (){
    setState(() {
      double weight = double.parse(weightController.text);
      double high = double.parse(highController.text)/100;
      double imc = weight / (high * high);
      if(imc<18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        print(imc);
      } else if (imc>=18.6 && imc<24.9){
        _infoText = "Seu peso está ideal! IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc>=24.9 && imc<29.9){
        _infoText = "Você está levemente acima do peso IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc>=29.9 && imc<34.9){
        _infoText = "Obesidade Grau I IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc>=34.9 && imc<39.9){
        _infoText = "Obesidade Grau II IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc>=40){
        _infoText = "Obesidade Grau III IMC: (${imc.toStringAsPrecision(4)})";
        }
    });
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso em (Kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: weightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Este campo é obrigatório.";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura em (Cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: highController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Este campo é obrigatório.";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ],
            ),
          )
        ));
  }
}
