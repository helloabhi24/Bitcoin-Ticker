import 'dart:convert';
import 'package:http/http.dart' as http;

const apikey = '0866CC93-BB66-4B09-9D3F-FAB0AAE9DE6D';
const url = 'https://rest.coinapi.io/v1/exchangerate';

class NetworkHelper {
  NetworkHelper({this.usd});
  final String usd;

  Future getData() async {
    http.Response response = await http.get('$url/BTC/$usd?apikey=$apikey');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      var rateChange = body['rate'];
      return rateChange;
    } else {
      print('this is code of status ${response.statusCode}');
    }
  }
}

// void callAPI() async {
//     http.Response response = await http.get(
//         'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=164A8B4F-3D72-42F7-98EA-14BCB9879FDE');
//     var bitData = response.body;
//     print(bitData[1]);
//   }
