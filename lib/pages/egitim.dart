//arayüz olmuş oldu
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class egitim extends StatefulWidget {
  const egitim({Key? key}) : super(key: key);

  @override
  State<egitim> createState() => _egitimState();
}

class _egitimState extends State<egitim> {
  String _filePath = "";

//DİZİNİ BELİRLEME
  Future<String> get _localDevicePath async {
    final _devicePath = await getApplicationDocumentsDirectory();
    return _devicePath.path;
  }
//DOSYA ADI VE YOLU
  Future<File> _localFile({required String path, required String type}) async {//null sfty htsı için required
    String _path = await _localDevicePath;

    var _newPath = await Directory("$_path/$path").create();
    return File("${_newPath.path}/beyza.$type");
  }
//PDF İNDİRME
  Future _downloadSamplePDF() async {
    final _response = await http.get(Uri.parse(
        "https://adana.tarimorman.gov.tr/Belgeler/SUBELER/bitkisel_uretim_ve_bitki_sagligi_sube_mudurlugu/sebze_yetistiriciligi_ve_mucadelesi/Domates.pdf"));
    if (_response.statusCode == 200) {
      final _file = await _localFile(path: "pdflerDizinAdi", type: "pdf");
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      print("Dosya yazma işlemi tamamlandı. Dosyanın yolu: ${_saveFile.path}");
      setState(() {
        _filePath = _saveFile.path;
      });
    } else {
      print(_response.statusCode);
    }
  }
/*
  Future _downloadSampleVideo() async {
    final _response = await http
        .get(Uri.parse("https://samplelib.com/lib/download/mp4/sample-5s.mp4"));//
    if (_response.statusCode == 200) {
      final _file = await _localFile(
        path: "mp4s",
        type: "mp4",
      );
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      print("Dosya yazma işlemi tamamlandı. Dosyanın yolu: ${_saveFile.path}");
      setState(() {
        _filePath = _saveFile.path;
      });
    } else {
      print(_response.statusCode);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tomato.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Text('Domates yetiştiriciliği hakkında bilgi sahibi olmak için yardımcı kaynaklar aşağıda bulunmaktadır.'),
                    SizedBox(height: 15),
                    TextButton.icon(
                      icon: Icon(Icons.file_download,color: Colors.red,),
                      label: Text("Bilgilendirici Pdf İndir", style: TextStyle(color: Colors.red,fontSize: 20),),
                      onPressed: () {
                        _downloadSamplePDF();
                      },
                    ),
                    /* TextButton.icon(
                    icon: Icon(Icons.file_download,color: Colors.red,),
                    label: Text("Bilgilendirici Video İndir", style: TextStyle(color: Colors.red,fontSize: 20),),
                    onPressed: () {
                      _downloadSampleVideo();
                    },
                  ),*/
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_filePath),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.tv,color: Colors.red,),
                      label: Text("İndirilen Dosyayı Göster", style: TextStyle(color: Colors.red,fontSize: 20),),
                      onPressed: () async {
                        final _openFile = await OpenFilex.open(_filePath);
                        print(_openFile);
                      },
                    ),

                    Text('Domates yaprağı hastalıklarına ait örnekler sırasıyla aşağıda yer almaktadır.'),
                    SizedBox(height: 15),

                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        child: Image.asset("assets/images/1.jpg"),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                'tek tıkla ulaştığınız "Bacterical Spot" hastalığına sahip domates yaprağını incelemektesiniz.',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )));
                        },
                      ),
                    ),

                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        child: Image.asset("assets/images/2.jpg"),
                        onDoubleTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                'çift tıkla ulaştığınız "Late Blight" hastalığına sahip domates yaprağını incelemektesiniz.',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )));
                        },
                      ),
                    ),

                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        child: Image.asset("assets/images/3.jpg"),
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                'uzun basışla ulaştığınız "Powdery Mildew" hastalığına sahip domates yaprağını incelemektesiniz.',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )));
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        child: Image.asset("assets/images/4.jpg"),
                        onLongPressUp: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                'uzun basışın sonu algılandığında ulaştığınız "Yellow Leaf Curl Virus" hastalığına sahip domates yaprağını incelemektesiniz.',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )));
                        },
                      ),
                    ),

                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        child: Image.asset("assets/images/5.jpg"),
                        onTapUp: (e) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(//e.toString()+
                                'tıklama bittiği an ulaştığınız "Septoria Leaf" hastalığına sahip yaprak fotoğrafını incelemektesiniz.',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )));
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}