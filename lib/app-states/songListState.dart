import 'package:flutter/material.dart';

import '../apimodule/api_service.dart';
import '../mediasModule/models/mediadata_model.dart';
import 'mediaPlayingState.dart';

import 'package:flutter/material.dart';
import '../apimodule/api_service.dart';
import '../mediasModule/models/mediadata_model.dart';
import 'mediaPlayingState.dart';

class SongListState extends ChangeNotifier {
  List<MediaModel> _mediasList = [];
  List<MediaModel> get mediasList => _mediasList;
  int currentMedia = 0;

  Future<void> gettingSongs() async {

    try {
      // Fetch songs from the API
      List<MediaModel> songs = await APIHandler.getMediasForSongs();
      // Update the mediasList with the fetched songs
      _mediasList = songs;
      // Notify listeners that the state has changed
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during fetching
      print("Error fetching songs: $e");
    }
  }
}
