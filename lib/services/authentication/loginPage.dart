import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  late String email,password;
  final formkey = GlobalKey<FormState>();
  final firebaseKimlikD= FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;// resim oranlı olsun diye
    var width = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.green[600],
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,//merhaba hoşgrldin solda baştan olsun diye

          children: [
            Center(
              child: Container(
                height: height* 0.10,
                width: width* 0.10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/siyah.png',),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(width:15,height: 15),
            const Text("Merhaba, \nHoşgeldin", style: TextStyle(color:Colors.white,fontSize:30,fontWeight: FontWeight.bold ),), //Yeni satır ters bu\
            const SizedBox(width:15,height: 15),

            TextFormField(
              validator: (value){//içine girileni bununla alacağız
                if(value!.isEmpty){//value mutlaka dolu gelecek diyorum null olamaz nulsafety mevzusu
                  return "bilgileri güzelce eksiksiz doldurun";
                }else{}
              },
              onSaved: (value){
                email=value!;//value mutlaka dolu olacak !diyorum
              },

              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(//İÇİNE TIKLAYINCA KENARLARIN ÇİZGİLİ OLMASI
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  icon: Icon(Icons.person),
                  hintText: 'emailinizi giriniz',   //yazmaya başlayınca gidiyor
                  labelText: 'email*',// yazsam bile bilgi amaçlı duruyor
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder() //dış renk tıklayınca değişmesi
              ),

            ),

            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "bilgileri güzelce eksiksiz doldurun";
                }else{}
              },
              onSaved: (value){
                password=value!;
              },

              obscureText: true,//şifre gözükmesin diye
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  icon: Icon(Icons.key),
                  hintText: 'şifrenizi giriniz',
                  labelText: 'şifre*',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),

            ),
            /*SizedBox(width:15,height: 15),
            Center(
                child: TextButton(
            onPressed: (){},
            child: Text("Şifremi Unuttum", style: TextStyle(color:Colors.white70),
                ),
                ),
            ),*/
            SizedBox(width:15,height: 20),
            Center(
              child: Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black26,
                ),
                child: TextButton(
                  onPressed: () async {
                    if(formkey.currentState!.validate()){//validate işlemi doğru yapıldıysa
                      formkey.currentState!.save();//email ve paswordu kaydetti
                      try{
                        final userResult = await firebaseKimlikD.signInWithEmailAndPassword(//uzun sürecek bir işlem olduğu için async yaptık
                            email: email, password: password);
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => MyStatefulWidget ()),
                        );
                      }catch(e){
                        print(e.toString());///herhangi bir hatada yazsın///ingilizce hataları türkçeye çevirme yapılabilir
                      }
                    }else{
                    }

                  },
                  child: Center(
                    child: Text("Giriş Yap", style: TextStyle(color:Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width:20,height: 20),

            Center(
              child: TextButton(
                onPressed: ()=> Navigator.pushNamed(context, "/siignUp"),//"routeadınolmalı"
                child: Text("Hesap Oluştur", style: TextStyle(color:Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
