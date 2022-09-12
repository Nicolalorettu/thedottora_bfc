import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:thedottora_bfc/api/pdf_api.dart';
import 'package:thedottora_bfc/api/pdfBodyFatResult.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:thedottora_bfc/main.dart';
import 'package:thedottora_bfc/parameters.dart';


class parametri extends StatefulWidget {
  const parametri({super.key});
  @override
  State<parametri> createState() => _parametri();
}
class _parametri extends State<parametri> {
  TextEditingController age = TextEditingController();
  TextEditingController biceps = TextEditingController();
  TextEditingController triceps = TextEditingController();
  TextEditingController subscapular = TextEditingController();
  TextEditingController supralliac = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController neck = TextEditingController();
  TextEditingController hips = TextEditingController();
  TextEditingController waist = TextEditingController();
  TextEditingController bioimpedanceanalysis = TextEditingController();
  TextEditingController namepatient = TextEditingController();
  List <double> costantsmalecaucasian =[23.81, 0.07, -0.134,0.12, 0.038, -13.011];
  List <double> costantsfemalecaucasian =[22.712, 0.07, -0.182,0.296, 0.013, -4.409];
  List <double> constantsmaleafro =[22.708, 0.065, -0.08, 0.043, 0.156, -26.806];
  List <double> constantsfemaleafro =[20.867, 0.052, -0.152, 0.14, 0.149, -8.227];
  List <double> constantsmalehispanic =[23.66, 0.04, -0.190, -0.036, 0.272, -26.41];
  List <double> constantsfemalehispanic =[23.871, 0.019, -0.118, -0.022, 0.249, -16.782];
  List <double> constantsmaleasian =[13.832, 0.02, -0.21, 0.081, 0.289, -0.65];
  List <double> constantsfemaleasian =[21.43, 0.036, -0.149, 0.241, 0.067, -7.525];
  List <double> noconst = [0,0,0,0,0,0];
  double checkmaleagemin = 18;
  List <double> checkmaleagemax = [0,96,107,84,87];
  List <double> checkmaleweightmin = [0,50.9,49.3,47.1,46.5];
  List <double> checkmaleweightmax = [0,130.0,133.4,123.5,90.5];
  List <double> checkmaleheightmin = [0,153,151.8,141.5,157.1];
  List <double> checkmaleheightmax = [0,198.4,200,189.5,185.1];

  List <double> checkfemaleagemin = [0,18,18,20,18];
  List <double> checkfemaleagemax = [0,91,94,110,88];
  List <double> checkfemaleweightmin = [0,40.6,45.8,39,36.7];
  List <double> checkfemaleweightmax = [0,120,129.1,106.1,88.2];
  List <double> checkfemaleheightmin = [0,141.8,142.5,136.5,141.4];
  List <double> checkfemaleheightmax = [0,183,182,171.5,173.5];
  //List <double> constantsmsjmale = [10,6.25,5,5];
  //List <double> constantsmsjfemale = [10,6.25,5,161];
  //List <double> constantsrhbmale = [13.397,4.799,5.677,88.362];
  //List <double> constantsrhbfemale = [9.247,3.089,4.330,447.593];
  List <double> constantskmunisex = [370,21.6,1];
  String? _dropdowngender;
  List<String> genders = ['Sesso','Uomo', 'Donna'];
  String? _dropdownrace;
  List<String> races = ['Etnia','Caucasico', 'AfroAmericano', 'Ispanico','Asiatico'];
  List<double>? parameters;
  List<double>? parametersf;
  List<double> constants = [];
  List<double> constantsbcm = [];
  double? equation;
  double? equationbcm;
  final pdf = pw.Document();
  final file = File("example.pdf");
  FocusNode myFocusNode = new FocusNode();

  List _setdata() {
    var constantmalematrix = List.generate(1,(j) => [noconst,costantsmalecaucasian, constantsmaleafro,constantsmalehispanic, constantsmaleasian], growable: false);
    var constantfemalematrix = List.generate(1,(j) => [noconst,costantsfemalecaucasian, constantsfemaleafro,constantsfemalehispanic, constantsfemaleasian], growable: false);
    return [constantmalematrix,constantfemalematrix];
  }


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
            ] ),"Parametri Paziente")),
          ),
          //drawer: const NavigationDrawer(),
          body: SingleChildScrollView(


            child: Column(

              children: <Widget>[

                Container(
                  margin: EdgeInsets.symmetric(vertical:80.0, horizontal:30.0),
                  child:
                  Text(

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,

                          fontStyle: FontStyle.italic,
                          letterSpacing: 6,
                          wordSpacing: 10,
                          shadows: [
                            Shadow(color: Colors.greenAccent, offset: Offset(2,1), blurRadius:20)
                          ]
                      ),
                      "Parametri Paziente"),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0, horizontal:30.0),
                  child: TextField(
                    controller: namepatient,

                    obscureText: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(vertical:18.0, horizontal:10.0),
                        labelText: 'Nome e Cognome',
                        labelStyle: TextStyle(
                          color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                          backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                        )
                    ),
                    //keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,

                  ),

                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical:40.0, horizontal:30.0),
                  child: TextField(
                    controller: age,
                    obscureText: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(vertical:18.0, horizontal:10.0),
                        labelText: 'Età',
                        labelStyle: TextStyle(
                          color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                          backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                        )
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,

                  ),

                ),
                Container(
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(
                        color: Colors.cyan,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical:10.0, horizontal:30.0),
                  padding: const EdgeInsets.symmetric(vertical:5.0, horizontal:10.0),
                  child: DropdownButton<String>(
                    value:_dropdowngender,

                    //elevation: 5,
                    style: TextStyle(color: Colors.black45),

                    items: genders.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Sesso",
                      style: TextStyle(
                          color: Colors.black45),
                    ),
                    underline: SizedBox(),
                    onChanged: (String? value) {
                      setState(() {
                        _dropdowngender = value;
                      });
                    },
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(
                        color: Colors.cyan,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical:40.0, horizontal:30.0),
                  padding: const EdgeInsets.symmetric(vertical:5.0, horizontal:10.0),
                  child: DropdownButton<String>(
                    value:_dropdownrace,

                    style: TextStyle(color: Colors.black45),

                    items: races.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        //color: value.color,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Etnia",
                      style: TextStyle(
                          color: Colors.black45),
                    ),
                    underline: SizedBox(),
                    onChanged: (String? value) {
                      setState(() {
                        _dropdownrace = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0, horizontal:30.0),
                  child: TextField(
                    controller: biceps,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Bicipite',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in mm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: triceps,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Tricipite',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in mm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: subscapular,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Sottoscapolare',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in mm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: supralliac,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Soprailiaca',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in mm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: weight,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Peso',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in kg',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: height,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Altezza',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in cm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),

                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: waist,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Girovita',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in cm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: neck,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Circonferenza collo',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in cm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: hips,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: const BorderSide(color: Colors.cyan, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical:20.0, horizontal:10.0),
                      labelText: 'Circonferenza fianchi',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore in cm',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
                  child: TextField(
                    controller: bioimpedanceanalysis,
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
                      labelText: 'Bioimpedenziometria',
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black45 : Colors.black45,
                        backgroundColor: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      ),
                      helperText: 'Valore rilevato dallo strumento',
                      helperStyle: (TextStyle(color: Colors.white)),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if((_dropdownrace == 'Etnia' || _dropdownrace == null) || (_dropdowngender == 'Sesso' ||_dropdowngender == null) || (age.text.isEmpty) || (biceps.text.isEmpty) || (triceps.text.isEmpty) || (subscapular.text.isEmpty) || (supralliac.text.isEmpty) || (weight.text.isEmpty) || (height.text.isEmpty) || (waist.text.isEmpty) ||(hips.text.isEmpty) || (neck.text.isEmpty)  ){
                        const snackBar = SnackBar(
                          content: Text('Dati Mancanti'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        for (int i = 1; i<= 4; i++){
                          if(_dropdowngender == genders[1].toString() && _dropdownrace == races[i].toString() && (int.parse(age.text) < checkmaleagemin || int.parse(age.text) > checkmaleagemax[i])){
                            const snackBar = SnackBar(
                              content: Text('Età non valida'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            break;
                          }else {
                            if(_dropdowngender == genders[2].toString() && _dropdownrace == races[i].toString() && (int.parse(age.text) < checkfemaleagemin[i] || int.parse(age.text) > checkfemaleagemax[i])) {
                              const snackBar = SnackBar(
                                content: Text('Età non valida'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            }
                          }
                          if(_dropdowngender == genders[1].toString() && _dropdownrace == races[i].toString() && (double.parse(weight.text) < checkmaleweightmin[i] || double.parse(weight.text) > checkmaleweightmax[i])){
                            const snackBar = SnackBar(
                              content: Text('Peso non valido'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            break;
                          }else {
                            if(_dropdowngender == genders[2].toString() && _dropdownrace == races[i].toString() && (double.parse(weight.text) < checkfemaleweightmin[i] || double.parse(weight.text) > checkfemaleweightmax[i])) {
                              const snackBar = SnackBar(
                                content: Text('Peso non valido'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            }
                          }
                          if(_dropdowngender == genders[1].toString() && _dropdownrace == races[i].toString() && (double.parse(height.text) < checkmaleheightmin[i] || double.parse(height.text) > checkmaleheightmax[i])){
                            const snackBar = SnackBar(
                              content: Text('Altezza non valida'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            break;
                          }else {
                            if(_dropdowngender == genders[2].toString() && _dropdownrace == races[i].toString() && (double.parse(height.text) < checkfemaleheightmin[i] || double.parse(height.text) > checkfemaleheightmax[i])) {
                              const snackBar = SnackBar(
                                content: Text('Altezza non valida'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            }
                          }
                          parameters = [(double.parse(biceps.text)+double.parse(triceps.text)+double.parse(subscapular.text)+double.parse(supralliac.text)),double.parse(age.text),double.parse(height.text),double.parse(weight.text),double.parse(waist.text),double.parse(hips.text),double.parse(neck.text)];
                          parametersf = [double.parse(biceps.text),double.parse(triceps.text),double.parse(subscapular.text),double.parse(supralliac.text),double.parse(age.text),double.parse(height.text),double.parse(weight.text),double.parse(waist.text),double.parse(hips.text),double.parse(neck.text)];
                          if(_dropdowngender == genders[1].toString() && _dropdownrace == races[i].toString()){
                            constants = _setdata()[0][0][i];
                            constantsbcm = [495,1.0324,0.19077,0.15456,450];
                            equationbcm = (constantsbcm[0]/(constantsbcm[1]-constantsbcm[2]*(log(parameters![4]-parameters![6])/ln10)+constantsbcm[3]*(log(parameters![2])/ln10))-constantsbcm[4]);
                          }else{
                            if(_dropdowngender == genders[2].toString() && _dropdownrace == races[i].toString()){
                              constants = _setdata()[1][0][i];
                              constantsbcm = [495,1.29579,0.35004,0.22100,450];
                              equationbcm = (constantsbcm[0]/(constantsbcm[1]-constantsbcm[2]*(log(parameters![4]+parameters![5]-parameters![6])/ln10)+constantsbcm[3]*(log(parameters![2])/ln10))-constantsbcm[4]);
                            }
                          }
                        }
                        equation = ((log(parameters![0])/ln10)*constants[0])+(parameters![1]*constants[1])+(parameters![2]*constants[2])+(parameters![3]*constants[3])+(parameters![4]*constants[4])+(constants[5]);

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                side: BorderSide(color: Colors.cyan, width: 5.0)),
                            contentPadding: const EdgeInsets.symmetric(vertical:15.0, horizontal:30.0),
                            //contentPadding: EdgeInsets.only(top: 10.0),
                            title: const Center(child:Text(style: TextStyle(color: Colors.cyan),'Calcolo Grasso Corporeo')),
                            content: Text('Durnin Womersley: ' + equation!.toStringAsFixed(1)+' %' +'\n'+ '\n'+ 'Circonferenze: '+equationbcm!.toStringAsFixed(1)+' %' +'\n'+ '\n'+ 'Bioimpedenziometria: '+bioimpedanceanalysis.text+' %',),

                            actions: <Widget>[
                              SizedBox(

                                  child: Row(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () => {Navigator.pop(context, 'Reset'),Phoenix.rebirth(context)},
                                          child: const Text('Ricomincia'),
                                        ),
                                        TextButton(
                                          onPressed: () => {Navigator.pop(context, 'OK')},
                                          child: const Text('OK'),
                                        ),
                                        TextButton(
                                          onPressed: () async {Navigator.pop(context, 'Download');PdfBFR.generate(parametersf!, equation!.toStringAsFixed(1),equationbcm!.toStringAsFixed(1),bioimpedanceanalysis.text,namepatient.text );
                                          //print(await PdfApi.checkFile());
                                          if(await PdfApi.checkFile() == true){
                                            const snackBar = SnackBar(
                                              content: Text('Download completato in: Download/BFC'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);}},
                                          child: const Text('Scarica PDF'),
                                        ),
                                      ])
                              )

                            ],

                          ),
                        );

                      };

                    },
                    child: const Text('Salva Dati',style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

