import 'dart:convert';
import 'dart:io';
import '../models/BahceSerasi_model.dart';
import 'package:http/http.dart' as http;

Future<BahceSerasi> fetchBahceSerasi() async {
  final response = await http //isteğini atıyor
      .get(Uri.parse('https://api.collectapi.com/health/dutyPharmacy?ilce=%C3%87ankaya&il=Ankara'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'apikey apikey 4GheqMQJpC9v6OBwjVDzKV:018IOSJzywXKeKaLNquzj5',//owblot tan aldım tokenı maile gönderdiler
    },);//istek attığım yer api key

  if (response.statusCode == 200) {
    // Sunucu 200 OK yanıtı döndürdüyse, sonra JSON'u ayrıştırın.
    return BahceSerasi.fromJson(jsonDecode(response.body));//eşleştirme doğruysa
  } else {
    // Sunucu 200 OK yanıtı döndürmediyse, bir istisna atın.
    throw Exception('Failed to load BahcesSerasi');
  }
}