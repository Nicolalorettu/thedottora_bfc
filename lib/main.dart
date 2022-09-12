import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:thedottora_bfc/api/pdf_api.dart';
import 'package:thedottora_bfc/api/pdfBodyFatResult.dart';
import 'package:thedottora_bfc/parameters.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(Phoenix(child:const TdBfc()));
}

Future initialization(BuildContext? context) async{
  await Future.delayed(Duration(seconds:3));
}

class TdBfc extends StatelessWidget {

  const TdBfc({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Dottora BFC',
      theme: ThemeData(
        primarySwatch: Colours.darkTurquoise,

      ),
      //initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        //'/': (context) => const TdBfc(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const parametri(),
      },
      home: const MyHomePage(title: 'NutriTool 2.0b'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        ] ),widget.title)),
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(


      child: Column(

          children: <Widget>[
            Container(
              height: 470.0,
              width: 2048.0,
              margin: EdgeInsets.symmetric(vertical:10.0, horizontal:30.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Home.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
            ),
            Container(
              height: 190.0,
              width: 2048.0,
              margin: EdgeInsets.symmetric(vertical:10.0, horizontal:30.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/texthome.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ]
      ),
      ),
        ),
    ]
    );
  }
  }
class NavigationDrawer extends StatelessWidget{
  const NavigationDrawer({Key? key}) : super();
  @override
  Widget build(BuildContext context) =>Container(
      alignment: Alignment(-1,-0.8),
      child: SizedBox(
          height: MediaQuery.of(context).size.height /1.9,
  child: Drawer(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        side: BorderSide(color: Colors.cyan, width: 5.0)),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  )));
  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      //top: MediaQuery.of(context).padding.top,
    )
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
    runSpacing: 16,
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Home'),
        onTap:() =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TdBfc(),)),
      ),
      ListTile(
        leading: const Icon(Icons.app_registration),
        title: const Text('Parametri Paziente'),
        onTap:()=>{
          Navigator.pop(context),
            Navigator.pushNamed(context, '/second'),},
      ),
      ListTile(
        leading: const Icon(Icons.accessibility_new_outlined),
        title: const Text('Calcolo Grasso Corporeo'),
        onTap:(){},
      ),
      ListTile(
        leading: const Icon(Icons.timeline_outlined),
        title: const Text('Calcolo Metabolismo Basale'),
        onTap:(){},
      ),
      const Divider(color: Colors.black45),
      ListTile(
        leading: const Icon(Icons.settings_power_outlined),
        title: const Text('Esci'),
        onTap:(){},
      )
    ],
  ));
}