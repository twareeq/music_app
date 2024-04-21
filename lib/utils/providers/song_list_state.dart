import 'package:flutter/material.dart';

import '../../config/api_service.dart';
import '../../models/api_models/mediadata_model.dart';

class SongListState extends ChangeNotifier {
  //State of the songs in the database
  List<MediaModel> _allMedias = [];
  List<MediaModel> _mediasList = []; //Listernets
  List<MediaModel> _sermonsList = []; //Listernets

  List<MediaModel> get allMedias => _allMedias;
  List<MediaModel> get mediasList => _mediasList;
  List<MediaModel> get sermonsList => _sermonsList;

  int _currentSongIndex = 0;
  dynamic _dynamicListModel;

  //Current Song We Are Playing
  int get currentSongIndex => _currentSongIndex; // Listers
  dynamic get dynamicListModel => _dynamicListModel;

  void updateDynamicListModel({required dynamic dynamicList}) {
    _dynamicListModel = dynamicList;
    notifyListeners();
  }

  void updateSongIndex({required int currentIndex}) {
    _currentSongIndex = currentIndex;
    notifyListeners();
  }

  void playNextMedia({required int currentIndex}) {
    if (currentIndex == mediasList.last) {
      print('There is nothing to play next');
    } else if (currentIndex < mediasList.length - 1) {
      _currentSongIndex++;
      notifyListeners();
    }
  }

  void playPreviousMedia({required int currentIndex}) {
    if (currentIndex > 0) {
      _currentSongIndex--;
      notifyListeners();
    }
  }

  //Get Songs from the database
  Future<void> gettingAllMediaFiles() async {
    try {
      if (_allMedias.isEmpty) {
        // Fetch songs from the API
        List<MediaModel> songs = await APIHandler.getAllMedias();
        // Update the mediasList with the fetched songs
        _allMedias = songs;
        // Notify listeners that the state has changed
      } else {
        print('No New Data');
      }
      notifyListeners(); //
    } catch (e) {
      // Handle any errors that occur during fetching
      print("Error fetching songs: $e");
    }
  }

  //Get Songs from the database
  Future<void> gettingSongs() async {
    try {
      if (_mediasList.isEmpty) {
        // Fetch songs from the API
        List<MediaModel> songs = await APIHandler.getMediasForSongs();
        // Update the mediasList with the fetched songs
        _mediasList = songs;
        // Notify listeners that the state has changed
      } else {
        print('No New Data');
      }
      notifyListeners(); //
    } catch (e) {
      // Handle any errors that occur during fetching
      print("Error fetching songs: $e");
    }
  }

  //Get Sermons from the database
  Future<void> gettingSermons() async {
    try {
      if (_sermonsList.isEmpty) {
        // Fetch sermons from the API
        List<MediaModel> sermons = await APIHandler.getMediasForSermons();
        // Update the mediasList with the fetched sermons
        _sermonsList = sermons;
        // Notify listeners that the state has changed
      } else {
        print('No New Data');
      }
      notifyListeners(); //
    } catch (e) {
      // Handle any errors that occur during fetching
      print("Error fetching songs: $e");
    }
  }
}
