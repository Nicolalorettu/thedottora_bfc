import 'dart:io';

import 'package:flutter/services.dart';
import 'package:thedottora_bfc/api/pdf_api.dart';
import 'package:thedottora_bfc/main.dart' as main;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBFR {
  static Future<File> generate(List <double> Parametri, String equazionedw, String equazionec, String bioimpedenza, String nomepaz) async {
    final pdf = Document();
    var assetImage = MemoryImage(
      (await rootBundle.load('assets/images/momocartoon.png'))
          .buffer
          .asUint8List(),
    );

    final customFont =
    Font.ttf(await rootBundle.load('assets/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader('The Dottora', assetImage),
          SizedBox(height: 0.5 * PdfPageFormat.cm),

          buildCustomHeadline(),
          Bullet(text: 'Nome: ' + nomepaz),
          Bullet(text: 'Età: ' + Parametri[4].toString()+ ' Anni'),
          Bullet(text: 'Peso: ' + Parametri[6].toString() +' Kg'),
          Bullet(text: 'Altezza: ' + Parametri[5].toString()+ ' cm'),

          Bullet(text: 'Bicipite: ' + Parametri[0].toString()+ ' mm'),
          Bullet(text: 'Tricipite: ' + Parametri[1].toString()+ ' mm'),
          Bullet(text: 'Sottoscapolare: ' + Parametri[2].toString()+ ' mm'),
          Bullet(text: 'Soprailiaca: ' + Parametri[3].toString()+ ' mm'),
          Bullet(text: 'Girovita: ' + Parametri[7].toString()+ ' cm'),
          Bullet(text: 'Circonferenza collo: ' + Parametri[9].toString()+ ' cm'),
          Bullet(text: 'Circonferenza fianchi: ' + Parametri[8].toString()+ ' cm'),
          buildCustomMiddleline(),
          Bullet(text: 'Equazione Durnin Womersley: ' + equazionedw+ ' %',style:TextStyle(fontSize: 17)),
          Bullet(text: 'Equazione Circonferenze Corpo: ' + equazionec+ ' %',style:TextStyle(fontSize: 17)),
          Bullet(text: 'Bioimpedenziometria Strumento: ' + bioimpedenza+ ' %',style:TextStyle(fontSize: 17)),


        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black),
            ),
          );

        },
      ),
    );
    return PdfApi.saveDocument(name: 'Calcolo grasso corporeo.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader(String nomedottore, var image) => Container(
    padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
    ),
    child: Row(
      children: [
        //PdfLogo(),
        SizedBox(width: 0.1 * PdfPageFormat.cm),
        Image(image,height: 50,width: 50),
        Text(
          '                            '+nomedottore +' Body Fat Calculator',
          style: TextStyle(
            fontSize: 20,
            color: PdfColors.blue,
            ),
          //textAlign: TextAlign.right,
        ),
      ],
    ),
  );

  static Widget buildCustomHeadline() => Header(
    child: Text(
      'Parametri Personali',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: PdfColors.white,
      ),
    ),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: PdfColors.cyan),
  );
  static Widget buildCustomMiddleline() => Header(
    child: Text(
      'Misurazioni Ottenute',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: PdfColors.white,
      ),
    ),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: PdfColors.cyan),
  );




}