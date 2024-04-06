import 'package:flutter/material.dart';

import '../apimodule/api_service.dart';
import '../mediasModule/models/mediadata_model.dart';
import 'mediaPlayingState.dart';

class SongListState extends ChangeNotifier {

  List<MediaModel> _mediasList = [];
  List<MediaModel> get mediasList => _mediasList;

  void updateSongList(List<MediaModel> newSongList) {
    _mediasList = newSongList;
    notifyListeners();
  }

  Future<void> gettingSongs() async {
    _mediasList = await APIHandler.getMediasForSongs();
    notifyListeners();
  }
}
