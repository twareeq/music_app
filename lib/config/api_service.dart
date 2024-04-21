import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/api_models/mediadata_model.dart';

class APIHandler {
  static Future<List<MediaModel>> getAllMedias() async {
    const url = 'http://10.0.2.2:3000/media';
    return _fetchMedias(url);
  }

  static Future<List<MediaModel>> getMediasForSongs() async {
    const url = 'http://10.0.2.2:3000/media/category/1';
    return _fetchMedias(url);
  }

  static Future<List<MediaModel>> getMediasForSermons() async {
    const url = 'http://10.0.2.2:3000/media/category/2';
    return _fetchMedias(url);
  }

  static Future<List<MediaModel>> getMediasForTestmonies() async {
    const url = 'http://10.0.2.2:3000/media/category/3';
    return _fetchMedias(url);
  }

  // static Future<MediaModel> getMedia({required int id}) async {
  //   const response = 'http://10.0.2.2:3000/play/$id';

  //   // {
  //   //   id: "",
  //   //   url: "",
  //   //   title: ""
  //   // }

  //   const media = MediaModel(id: response["id"], title:response["title"],);

  //   return media;
  // }

  static Future<List<MediaModel>> _fetchMedias(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonData = jsonDecode(body);

    // print(jsonData[0]);
    List tempList = [];

    for (var v in jsonData) {
      // print("v $v \n\n");
      print('Data fetched successfull!!');
      tempList.add(v);
    }
    return MediaModel.mediaFilesFromSnap(tempList);
  }
}
