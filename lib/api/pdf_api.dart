import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  Future<File> generateCenteredText(String text) async {
    final pdf = Document();


    pdf.addPage(Page(
      build: (context) => Center(
        child: Text(text, style: TextStyle(fontSize: 48)),
      ),
    ));

    return saveDocument(name: 'CalcoloGrassoCorporeo.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final root = await getApplicationDocumentsDirectory();
    print(root);
    final directory = Directory ("/storage/emulated/0/Download/BFC");
    final bytes = await pdf.save();
    File? file;

    if (await _requestPermission(Permission.storage)) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
          File saveFile = File(directory.path + "/$name");
          await saveFile.writeAsBytes(bytes);
          return saveFile;

        }else{
            File saveFile = File(directory.path + "/$name");
            await saveFile.writeAsBytes(bytes);
            return saveFile;
        }

      }

    return file!;
  }


    static Future<bool> _requestPermission(Permission permission) async {
        if (await permission.isGranted) {
          return true;
        } else {
          var result = await permission.request();
          if (result == PermissionStatus.granted) {
            return true;
          }
        }
        return false;
      }

  static Future<bool> checkFile() async {
    if (await _requestPermission(Permission.storage)){return true;}else{return false;}
    //await
  }

}