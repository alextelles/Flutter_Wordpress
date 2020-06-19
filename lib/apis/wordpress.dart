import 'package:http/http.dart' as http;
import 'dart:convert';

final dominiourl = 'https://www.vitorcorrea.com/wp-json/wp/v2/posts?_embed';

Future<List> teste() async {
  final response =
      await http.get(dominiourl, headers: {'Accept': 'application/json'});
  var converterjson = jsonDecode(response.body);
  return converterjson;
}
