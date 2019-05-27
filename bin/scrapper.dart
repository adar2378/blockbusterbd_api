import 'dart:convert'; // Contains the JSON encoder

import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

Future initiate() async {
  var client = Client();
  Response response =
      await client.get('https://blockbusterbd.com/now_showing.php');
  var document = parse(response.body);
  List<Element> movieNames = document.querySelectorAll(
      'div.active>div.row>div.grid_bottom_margin > h5.text_align_style_center');
  List<Element> casts = document.querySelectorAll(
      'div.active>div.row>div.grid_bottom_margin > p.text_align_style_center');
  List<Map<String, dynamic>> linkMap = [];

  print(casts.length);
  print(movieNames.length);
  for (int i = 0; i < movieNames.length; i++) {
    String cast, genre;

    // print(movieNames[i].text.trim());
    for (int j = i * 3, counter = 0; counter < 2; counter++, j++) {
      if (counter == 0) {
        cast = casts[j].text ?? "null";
      } else if (counter == 1) {
        genre = casts[j].text ?? "null";
      } else {
        break;
      }
    }
    linkMap.add({
      'title': movieNames[i].text.trim(),
      'casts': cast.trim(),
      'genre': genre.trim()
    });
  }
  for (int j = 0; j < casts.length; j++) {
    print(casts[j].text.trim());
  }
  return json.encode(linkMap);
}
