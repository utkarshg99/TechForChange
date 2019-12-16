import 'package:http/http.dart' as http;
import 'dart:convert';
String url;

Future fetchURL() async {
  var response = await http.get('https://utkarshgx.web.app/tfc.json');
  if(response.statusCode == 200){
    url = json.decode(response.body)['url'];
    print(url);
  }
}