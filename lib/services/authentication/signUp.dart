import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  late String email,password;//late vermeyince null olamaz diyor latele ilerde değer alacak o zamna kadar sorunsuz çalış diyoruz
  final formkey = GlobalKey<FormState>(); ///formu dışardan kontrol etmek için oluşturdum
  final firebaseKimlikD= FirebaseAuth.instance;//FirebaseAuth daki authentication metotlara firebaseKimlikD ile

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;// resim oranlı olsun diye
    var width = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.green[600],
      body: Column(
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

          Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(width:15,height: 15),
                Text("Merhaba, \nHoşgeldin", style: TextStyle(color:Colors.white,fontSize:30,fontWeight: FontWeight.bold ),), //Yeni satır ters bu\
                SizedBox(width:15,height: 15),

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
                      focusedBorder: OutlineInputBorder(
                        //İÇİNE TIKLAYINCA KENARLARIN ÇİZGİLİ OLMASI
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      icon: Icon(Icons.person),
                      hintText: 'emailinizi giriniz',
                      //yazmaya başlayınca gidiyor
                      labelText: 'email*',
                      // yazsam bile bilgi amaçlı duruyor
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

                /* TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      icon: Icon(Icons.key),
                      hintText: 'şifrenizi tekrar giriniz',
                      labelText: 'şifre tekrar*',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder()),
                ),*/

                SizedBox(width:15,height: 15),

                Center(
                  child: TextButton(
                    onPressed: () async {
                      if(formkey.currentState!.validate()){
                        //currentState mutlaka dolu olacak validate(girilen değeri alan) metodunu çalıştır
                        formkey.currentState!.save();//validatın boş değil kısmı doğru yapıldıydsa onsaved save etme çalışacak
                        try{
                          var userResult = await firebaseKimlikD.createUserWithEmailAndPassword(
                              email: email, password: password);//uzun sürecek işlem futurre yaptık
                          formkey.currentState!.reset();//mail şifre form elamanlarını sıfırlıyor kayıt oldu bir daha durmasına gerek yok
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("hesap oluşturma başarıyla tamamlandı,giriş sayfasına yönlendiriliyorsunuz"),
                            ),);
                          print(userResult.user!.uid);
                          Navigator.pushReplacementNamed(context, "/looginPage");//geri tuşuna basınca bu sayfaya gelmesin unutsun
                        }catch(e){
                          print(e.toString());}


                      }else{}
                    },
                    child: Text("Hesap Oluştur", style: TextStyle(color:Colors.white70),
                    ),
                  ),
                ),

                SizedBox(width:15,height: 15),

                Center(
                  child: TextButton(
                    onPressed: ()=> Navigator.pop(context), //pushNamed(context, "looginPage"),
                    child: Text("Sayfaya Geri Dön", style: TextStyle(color:Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
