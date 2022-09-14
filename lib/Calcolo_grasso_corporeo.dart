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

class calcolograssocorporeo extends StatefulWidget {
  const calcolograssocorporeo({super.key});
  @override
  State<calcolograssocorporeo> createState() => _calcolograssocorporeo();
}

class _calcolograssocorporeo extends State<calcolograssocorporeo> {

  List<String> loaddata() {
    var file = File("/storage/emulated/0/Download/Nutritool/data.txt");
    List<String> data = file.readAsLinesSync();
    return data;
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
            ] ),"Calcolo Grasso Corporeo")),
          ),

            body: ListView(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical:50.0, horizontal:30.0),
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

                    'Risultati del calcolo',

                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical:30.0, horizontal:30.0),
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
                  DataColumn(label: Text('Formula di Calcolo',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                  DataColumn(label: Text('Valore', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                ],
                rows: [
                  DataRow (
                      //color: MaterialStateProperty.all(Colors.cyan),
                      cells: [
                    DataCell(Text('Durnin Womersley:', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                    DataCell(Text(loaddata()[1],style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                  ]),
                  DataRow(
                      //color: MaterialStateProperty.all(Colors.lightBlueAccent),
                      cells: [
                    DataCell(Text('Circonferenze:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                    DataCell(Text(loaddata()[2], style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                  ]),
                  DataRow(
                      //color: MaterialStateProperty.all(Colors.cyan),
                      cells: [
                    DataCell(Text('Bioimpedenziometria:',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))),
                    DataCell(Text(loaddata()[3],style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic, color: Colors.black))),
                  ]),
                ],
              ),
              ),
            ]),
        ),
      ],
    );
  }

}