import 'dart:io';
import 'package:flutter/material.dart';
import '../services/dosya_utils.dart';

class resultPage extends StatefulWidget{
  const resultPage({super.key});

  @override
  State<resultPage> createState() {
    return resultPageState();
  }
}

class resultPageState extends State<resultPage> {
  String fileContents = "Veri Yok";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/tomato.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.amber[100],
                      border: Border.all(
                          color: Colors.black , width: 5.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15.0)),
                ),


                Container(
                  width: 280,
                  height: 150,
                  //alignment: Alignment.topLeft,
                  child: Column(//3 satırın sütunu
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      Row(//dosya okuma satırı a serasının mahsülü
                        children: [

                          ElevatedButton(
                            child: Text("Sera İsmi"),
                            onPressed: () {
                              FileUtils.readFromFile().then((contents) {
                                setState(() {
                                  fileContents = contents;
                                });
                              });
                            },
                          ),
                          Text(fileContents,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ],
                      ),

                      Row(//hastalık sınıfının geldiği
                        children: [
                          Text(
                            "Container",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ],
                      ),

                      Row(//konumu ya da saati alan yer
                        children: [
                          Text(
                            "Container",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber[100],
                      border: Border.all(
                          color: Colors.black, width: 5.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15.0)),

                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Sonuçlar'),
              onPressed: () {
                /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const cameraPage()),
                  );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}



