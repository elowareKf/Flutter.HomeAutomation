import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeServer {
  static String baseUrl = 'http://192.168.178.64:3000/api/revolution/';

  static dynamic _getHeader() => {'Content-Type': 'application/json'};

  Future<List<Io>> getState() async {
    var result = await http.get(baseUrl, headers: _getHeader());

    if (result.statusCode != 200) throw 'Communication problem';

    var ioState = jsonDecode(result.body);
    return _decodeResponse(ioState);
  }

  List<Io> _decodeResponse(Map<String, dynamic> ioState) {
    var resultList = List<Io>();
    for (int i = 0; i < ioState["values"].length; i++) {
      var item = Io();
      item.id = i;
      item.value = ioState["values"][i];

      if (ioState["names"].length > i)
        item.name = ioState["names"][i];
      else
        item.name = 'Item #$i';

      resultList.add(item);
    }
    return resultList;
  }

  Future<List<Io>> sendIoCommand(int io, int value) async {
    var result = await http.put(baseUrl,
        body: jsonEncode({"io": io, "value": value}), headers: _getHeader());

    if (result.statusCode != 200) throw 'Communication problem';

    var ioState = jsonDecode(result.body);

    return _decodeResponse(ioState);
  }
}

class IoResult {
  List<String> names;
  List<int> values;
}

class Io {
  int id;
  String name;
  int value;
}
