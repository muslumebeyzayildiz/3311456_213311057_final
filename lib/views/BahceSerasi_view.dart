import 'dart:math';
import 'package:flutter/material.dart';
import '../models/BahceSerasi_model.dart';
import '../services/BahceSerasi_services.dart';

class apiPage extends StatefulWidget {
  const apiPage({super.key});

  @override
  State<apiPage> createState() => _apiPageState();
}

class _apiPageState extends State<apiPage> {
  late Future<BahceSerasi> futureBahceSerasi;

  @override
  void initState() {
    super.initState();
    futureBahceSerasi = fetchBahceSerasi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("Tarımsal Adresler"),
      ),
      body: Center(
        child: FutureBuilder<BahceSerasi>(
          future: futureBahceSerasi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.result![0].address);//returnden sonraydı listview getirdik Text(snapshot.data!.result.toString())
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.result?.length,//snapshotla eriştiğim datanın sonucu kadar uzunluk
                  itemBuilder: (BuildContext context, int index) {
                    Random random = new Random();

                    int colorCode =  random.nextInt(10);

                    return Container(
                      height: 50,
                      color: Colors.green[colorCode * 100],
                      child: Center(child: Text('${snapshot.data!.result![index].address}')),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            //Varsayılan olarak, bir yükleme çarkı gösteriyor.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );

  }
}