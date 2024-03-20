import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app/mediasModule/models/mediadata_model.dart';

class APIHandler {
  static Future<List<MediaModel>> getMedias() async {
    const url = 'http://localhost:3000/media';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonData = jsonDecode(body);

    // print(jsonData[0]);
    List tempList = [];

    for (var v in jsonData) {
      print("v $v \n\n");
      tempList.add(v);
    }
    return MediaModel.mediaFilesFromSnap(tempList);
  }
}
