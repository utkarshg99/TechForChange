import 'package:http/http.dart' as http;
import 'dart:convert';
String url = 'http://ec2-54-145-175-97.compute-1.amazonaws.com';

Future fetchURL() async {
  // var response = await http.get('https://utkarshgx.web.app/tfc.json');
  // if(response.statusCode == 200){
  //   url = json.decode(response.body)['url'];
  // }

  url = 'ec2-54-145-175-97.compute-1.amazonaws.com';

}