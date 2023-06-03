import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Konum_model.dart';
import '../services/db_utils.dart';
import '../views/list_Konumlar.dart';

DbUtils utils = DbUtils();

class cameraPage extends StatefulWidget{
  const cameraPage({super.key});

  @override
  State<cameraPage> createState() {
    return cameraPageState();
  }
}

class cameraPageState extends State<cameraPage> {

  final ImagePicker _picker = ImagePicker();
  File? _file;//_file yüklenecek dosya
  Future<void>kameradanResimSec()async{
    try{//hata yakalama için
      var alinanResim= await _picker.pickImage(source: ImageSource.camera);
      if(alinanResim==null) return;
      print(alinanResim.path);//çekilen fotonun yolunu yazsın
      //result.saveTo(path)  istediğim yere kaydetmek için
      ///result.lastModified() hangi tarihte
      setState(() {
        _file= File(alinanResim.path);//_file a(yüklenecek resime) kameradan alinan resmin yolu gidiyor
      });

      alinanResim.readAsBytes().then((value){
        print(value);

        //hangi klasöre göndermek istediğim
        //onun altında bir klasör daha

      });
    }
    catch(e){
      print(e);
    }
  }



  TextEditingController konumIdController = TextEditingController();
  TextEditingController konumAdController = TextEditingController();
  TextEditingController konumYasController = TextEditingController();

  late Future<Database> database;

  List<Konum> konumList = [];

  _onPressedUpdate() async {
    final enik = Konum(
      id: int.parse(konumIdController.text),
      name: konumAdController.text,
      age: int.parse(konumYasController.text),
    );
    utils.updateKonum(enik);
    konumList = await utils.konumlar();
    //print(dogList);
    getData();
  }

  _onPressedAdd() async {
    final enik = Konum(
      id: int.parse(konumIdController.text),
      name: konumAdController.text,
      age: int.parse(konumYasController.text),
    );
    utils.insertKonum(enik);
    konumList = await utils.konumlar();
    //print(dogList);
    getData();
  }

  _deleteKonumTable() {
    utils.deleteTable();
    konumList = [];
    getData();
  }

  void getData() async {
    await utils.konumlar().then((result) => {
      setState(() {
        konumList = result;
      })
    });
    print(konumList);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  void didChangeAppLifecycleState(AppLifecycleState state) {
    getData();
  }

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
        child:Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _file != null ? Image.file(_file!, fit: BoxFit.cover,): SizedBox.shrink(),
                //SizedBox.shrink() Ebeveyninin izin verdiği ölçüde küçülecek bir kutu oluşturur.

                ElevatedButton(
                  child: const Text('Fotoğraf Çek'),
                  onPressed: () {
                    kameradanResimSec();
                  },
                ),

                //TODO SQLİTE KISMI

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: konumIdController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ID veriniz'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: konumAdController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Adresi giriniz'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: konumYasController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Parsel Numarasını giriniz'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _onPressedAdd, child: Text("Konum Ekle")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _onPressedUpdate, child: Text("KOnumu Güncelle")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _deleteKonumTable,
                      child: const Text("Konum Tablosunu Sil")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListKonumlar()),
                        );
                      },
                      child: Text("Konumları Listele")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        getData();
                      },
                      child: Text("Listeyi Yenile")),
                ),
                Text(konumList.length.toString()),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: konumList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(konumList[index].name),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



