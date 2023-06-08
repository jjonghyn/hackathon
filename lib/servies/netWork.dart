import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {

  final String url;

  NetworkHelper(this.url);

  //api로 받아온 데이터
  Future getData() async {
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
