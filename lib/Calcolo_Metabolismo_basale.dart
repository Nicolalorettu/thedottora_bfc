import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:thedottora_bfc/main.dart';
import 'package:thedottora_bfc/parameters.dart';
import 'package:permission_handler/permission_handler.dart';

List <double> constantskmunisex = [370,21.6,1];
List <double> multiplierbmr = [1.2,1.375,1.465,1.55,1.725,1.9];
class calcolometabolismobasale extends StatefulWidget {
  const calcolometabolismobasale({super.key});
  @override
  State<calcolometabolismobasale> createState() => _calcolometabolismobasale();
}

class _calcolometabolismobasale extends State<calcolometabolismobasale> {
  bool visible = false;

  List<String> loaddata() {
    var file = File("/storage/emulated/0/Download/Nutritool/data.txt");
    List<String> data = file.readAsLinesSync();
    return data;
  }
  TextEditingController grassocorporeo = TextEditingController();
  List<double> KatchMcArdleFormula(){
    var bmr = constantskmunisex[0]+(constantskmunisex[1]*(constantskmunisex[2]-(double.parse(grassocorporeo.text)/100)))*double.parse(loaddata()[0]);
    print(bmr);
    List<double> bmractivity = [];
    bmractivity.add(bmr);
    for(int i =0; i<multiplierbmr.length; i++){
      bmractivity.add(bmr*multiplierbmr[i]);
      };
    return bmractivity;
  }

  FocusNode myFocusNode = new FocusNode();

  @override

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/Carta.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: NewGradientAppBar(
            gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
            title: Center(child:Text(style: TextStyle(color: Colors.white,shadows: [
              Shadow(color: Colors.white24, offset: Offset(5,4), blurRadius:10)
            ] ),"Calcolo Metabolismo Basale")),
          ),

          body: ListView(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
            ),
            Center(
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,

                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                      wordSpacing: 1,
                      shadows: [
                        Shadow(color: Colors.greenAccent, offset: Offset(2,1), blurRadius:20)
                      ]),

                  'Formula Katch-McArdle',

                )),
            Container(
              margin: EdgeInsets.symmetric(vertical:30.0, horizontal:100.0),
              child:(
                  TextField(
                    controller: grassocorporeo,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Grasso Corporeo',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore manuale in percentuale',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal:100.0),
              child: ElevatedButton(
                  onPressed: () => {
                  setState(() {
                  visible = true;
                  }),

                  },
                child: const Text('Calcola BMR',style: TextStyle(color: Colors.white)),
              ),
            ),
            Visibility(
              visible: visible,
              child:
              Column(
              children: <Widget>[

                    Container(
                    margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                    child:
                    Text(

                    textAlign: TextAlign.left,
                    style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,

                    fontStyle: FontStyle.italic,
                    letterSpacing: 1,
                    wordSpacing: 1,
                    //shadows: [
                    //Shadow(color: Colors.greenAccent, offset: Offset(2,1), blurRadius:20)
                    //]
                    ),
                    "BMR = " +KatchMcArdleFormula()![0].toStringAsFixed(0)+" Calorie/giorno"),

                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical:30.0, horizontal:30.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: DataTable(

                  columns: [
                    DataColumn(label: Text('Livello Attività',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                    DataColumn(label: Text('Calorie', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                  ],
                  rows: [
                    DataRow (
                      //color: MaterialStateProperty.all(Colors.cyan),
                        cells: [
                          DataCell(Text('Sedentario: poco o nessun workout:', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![1].toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                    DataRow(
                      //color: MaterialStateProperty.all(Colors.lightBlueAccent),
                        cells: [
                          DataCell(Text('Workout 1-3 volte/settimana:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![2].toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                    DataRow(
                      //color: MaterialStateProperty.all(Colors.cyan),
                        cells: [
                          DataCell(Text('Workout 4-5 volte/settimana:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![3].toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                    DataRow(
                      //color: MaterialStateProperty.all(Colors.cyan),

                        cells: [
                          DataCell(Text('Esercizi ogni dì o workout intensi 3-4 volte/settimana:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![4].toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                    DataRow(
                      //color: MaterialStateProperty.all(Colors.cyan),
                        cells: [
                          DataCell(Text('Workout intensi 6-7 volte/settimana:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![5].toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                    DataRow(
                      //color: MaterialStateProperty.all(Colors.cyan),
                        cells: [
                          DataCell(Text('Workout intensi ogni dì o lavoro fisico:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                          DataCell(Text(KatchMcArdleFormula()![6].toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                        ]),
                  ],
                ),
              ),
            ]),
            )
          ]),
        ),
      ],
    );
  }

}