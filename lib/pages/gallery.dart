import 'dart:io';// File? _file için
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/dosya_utils.dart';

class galleryPage extends StatefulWidget{
  const galleryPage({super.key});

  @override
  State<galleryPage> createState() {
    return galleryPageState();
  }
}

class galleryPageState extends State<galleryPage> {
  final ImagePicker _picker = ImagePicker();

  String fileContents = "Veri Yok";
  final myController = TextEditingController();

  File? _fotoFile;//_fotoFile yüklenecek dosya

  /*final firebaseKimlikD= FirebaseAuth.instance;
 late String indirmeBaglantisi;
var yuklemeGorevi;*/

  Future<void>galeridenResimSec() async{
    try{
      var alinanResim2= await _picker.pickImage(source: ImageSource.gallery, imageQuality:100,maxHeight: 100,maxWidth: 100);//imaj kalitesi 0-100 arası değer
      if(alinanResim2==null) return;
      //seciliImagePath.value = result2.path;
      //seciliImageSize.value=((File(seciliImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+ "Mb";
      // print("fotoğraf kaydedildi");
      setState(() {
        _fotoFile= File(alinanResim2.path);
      });

      print(alinanResim2.path);
      alinanResim2.readAsBytes().then((value){//baytlarını okudu
        print(value);
      });
      print("ccccccc");

      /*result2.readAsString().then((value){
        print(value);
      });


      StorageReference referansYolu = FirebaseStorage.instance
       .ref()
          .child("domatesresimleri")   //hangi klasöre göndermek istediğim
          .child(firebaseKimlikD.currentUser!.uid)        //onun altında bir klasör daha
          .child("domatesRESMİ.png");

      StorageUploadTask yuklemeGorevi=referansYolu.putFile(_fotoFile);
      String url =await (yuklemeGorevi.onComplete).ref.getDownloadURL();//bu url ile gösterme yapacağız

      setState(() {
        indirmeBaglantisi=url;
      });*/
    }
    catch(e){
      print(e);
    }
  }

  /*  biz hep tekli fotoğraf göndereceğiz o yüzden detay yazmadım ama böylede bir şey var
  Future<void>cokluResimSec()async{
    try{//hata yakalama için
      var result= await _picker.pickImage(source: ImageSource.camera);
    }
    catch(e){
      print(e);
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

        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Card(child: Text("Seçtiğiniz Fotoğrafın Hangi Bahçenize Ait Olduğunu Not Etmek İçin Kullanabileceğiniz Alana Aşağıda Yer Verilmiştir: ",style: TextStyle(color: Colors.black,fontSize: 15),)),

              _fotoFile != null ? Image.file(_fotoFile!, fit: BoxFit.cover,): SizedBox.shrink(),
              //SizedBox.shrink() Ebeveyninin izin verdiği ölçüde küçülecek bir kutu oluşturur.
              // fit: BoxFit.cover, Bir kutu başka bir kutuya Hala tüm hedef kutusunu kaplarken mümkün olduğu kadar küçük yazılmalıdır.
              ElevatedButton(
                child: const Text('Galeriden Seç'),
                onPressed: () {
                  galeridenResimSec();

                },
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController,
                  cursorColor: Colors.blue,
                ),
              ),
              ElevatedButton(
                child: Text("Dosyaya Kaydet"),
                onPressed: () {
                  FileUtils.saveToFile(myController.text);
                },
              ),
              ElevatedButton(

                child: Text("Dosyadan Oku"),
                onPressed: () {
                  FileUtils.readFromFile().then((contents) {
                    setState(() {
                      fileContents = contents;
                    });
                  });
                },
              ),
              Text(fileContents,style: TextStyle(color: Colors.blue,fontSize: 20),),


            ],
          ),
        ),
      ),
    );
  }
}
