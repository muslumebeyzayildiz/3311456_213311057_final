import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tomato.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:Center(
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 60, 10, 60),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Uygulamamızın Amaç ve hedefleri:",
                        style: TextStyle(
                            color: Color(0xfff1887e),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Tarım, insanların yeryüzünde hayatta kalmasında hayati bir rol oynamaktadır. Aynı zamanda bir bölgenin besin kaynağı ve ekonomik büyümesinin ana kaynağı olarak işlev görmektedir. Fakat bilindiği gibi bitkiler, bakteri virüs,  mantar veya aşırı  tarım ilacı  kullanımı gibi çeşitli etkenlerden  dolayı olumsuz yönde  kolayca etkilenmektedirler. Tarım ürünlerini etkileyen birçok hastalığın yanlış teşhisi,  tarım ilaçlarının  gereksiz ve aşırı kullanılmasına yol  açmaktadır.   Bu durum  dirençli patojen tiplerinin oluşmasına, daha yüksek maliyete ve daha fazla salgına neden  olmaktadır. Bunların tümü ciddi mali ve çevresel kayıplara neden  olmaktadır.  Bu sebeple projemizde derin öğrenme yöntemleri kullanılarak  domates  yaprakları hastalıklarının otomatik sistemle  teşhisi gerçekleştirilecektir. Bu projede ele alınacak olan yaygın hastalıklar şunlardır:',
                      ),
                      Text('Bacterial Spot \n Late Blight \nPowdery Mildew\n Yellow Leaf Curl Virus \n Septoria Leaf'),
                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 290, right: 0, top: 0, bottom: 0),
                        child: Text("Hastalığı teşhis et...",
                            style: TextStyle(
                                color: Color(0xffec5345),
                                fontWeight: FontWeight.bold)),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
