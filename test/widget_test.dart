import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

  // final response = await http.get(
  //   url,
  //   headers: {"key": "ace05f1d065ff6a0266be36209a120c6"},
  // );

  // Uri url = Uri.parse("https://api.rajaongkir.com/starter/city");

  // final response = await http.get(
  //   url,
  //   headers: {"key": "ace05f1d065ff6a0266be36209a120c6"},
  // );

  // Uri url = Uri.parse("https://api.rajaongkir.com/starter/city?province=5");

  // final response = await http.get(
  //   url,
  //   headers: {"key": "ace05f1d065ff6a0266be36209a120c6"},
  // );

  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

  final response = await http.post(
    url,
    headers: {
      "content-type": "application/x-www-form-urlencoded",
      "key": "ace05f1d065ff6a0266be36209a120c6"
    },
    body: {"origin": 501, "destination": 114, "weight": 1700, "courier": "jne"},
  );

  print(response.body);
}
