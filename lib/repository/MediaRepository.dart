import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/api_models/mediadata_model.dart';

class MediaRepository {
  static Future<MediaModel> getSongFile({required int songId}) async {
    final url = 'http://localhost:3000/media/play/$songId';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final data = jsonDecode(body);

    return MediaModel.fromJson(data);
  }
}
