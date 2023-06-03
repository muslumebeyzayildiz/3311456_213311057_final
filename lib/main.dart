import 'package:domates_hastalik_tespit_uygulamasi/pages/camera.dart';
import 'package:domates_hastalik_tespit_uygulamasi/pages/egitim.dart';
import 'package:domates_hastalik_tespit_uygulamasi/pages/gallery.dart';
import 'package:domates_hastalik_tespit_uygulamasi/pages/grafik.dart';
import 'package:domates_hastalik_tespit_uygulamasi/pages/result.dart';
import 'package:domates_hastalik_tespit_uygulamasi/services/authentication/loginPage.dart';
import 'package:domates_hastalik_tespit_uygulamasi/services/authentication/signUp.dart';
import 'package:domates_hastalik_tespit_uygulamasi/views/BahceSerasi_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/firestorePage.dart';
import 'pages/home.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();//bu olmadan çalışmıyor
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,

      routes: {///string içine verdiğim ifade anahtar kelime ile sayfalar arası geçiş yapabiliyorum
        "/looginPage" : (context)=>loginPage(),//"/looginPage" çağırılınca loginPage() sayfasi açılacak
        "/siignUp" : (context)=> signUp(),
      },
      home:  const loginPage(),  //MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex=0 ;
  static  final List<Widget> _pages = <Widget>[
    homePage(),
    egitim(),
    apiPage(),
    galleryPage(),
    cameraPage(),
    resultPage(),
    BarChartSample2(),
    FirestorePage(),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domates Yaprağı Hastalık Tespiti'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tomato.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),

      //BOTTOM NAVİGATİON BAR
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          /// unselectedItemColor/selectedItemColor özellikleri olmasaydı böyle yapardık uzun yol
          /* _selectedIndex==0 ?
            BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp,color:Colors.red),
            label: 'Anasayfa',
          ) : BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp,color:Colors.blue),
            label: 'Anasayfa',
          ),*/

          BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Eğitici',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: 'Konum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_photo_alternate_rounded),
            label: 'Galeri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance_rounded),
            label: 'Kamera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_sharp),//crisis_alert_sharp
            label: 'Sonuclar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq_rounded),//crisis_alert_sharp
            label: 'Grafikler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),//crisis_alert_sharp
            label: 'Firestore',
          ),

        ],
        currentIndex: _selectedIndex,

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
