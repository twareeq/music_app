import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/api_models/mediadata_model.dart';
import 'package:music_app/repository/MediaRepository.dart';

class APIHandler {
  final mediaRepository = MediaRepository();

  static Future<List<MediaModel>> getAllMedias() async {
    const url = 'http://localhost:3000/media';
    return _fetchMedias(url);
  }

  static Future<List<MediaModel>> getMediasByCategory(
      {required int categoryId}) async {
    final url = 'http://localhost:3000/media/category/$categoryId';

    return _fetchMedias(url);
  }

  static Future<MediaModel> getSongFile({required int songId}) async {
    final song = await MediaRepository.getSongFile(songId: songId);

    return song;
  }

  // static Future<MediaModel> getMedia({required int id}) async {
  //   var response = "http://10.0.2.2:3000/play/$id";

  //   // {
  //   //   id: "",
  //   //   url: "",
  //   //   title: ""
  //   // }

  //   // const media = MediaModel(id: response["id"], title:response["title"],);
  //   var media = MediaModel(id: response["id"]);

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
