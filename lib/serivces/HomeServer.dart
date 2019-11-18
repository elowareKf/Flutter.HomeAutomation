import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeServer {
  static String baseUrl = 'http://192.168.178.64:3000/api/revolution/';

  Future<void> sendIoCommand(int io, int value) async {
    var result = await http.put(baseUrl,
        body: jsonEncode({"io": io, "value": value}),
        headers: {'Content-Type': 'application/json'});

    if (result.statusCode != 200) throw 'Communication problem';
  }
}
