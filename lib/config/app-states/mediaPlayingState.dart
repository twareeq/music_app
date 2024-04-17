import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../models/api_models/mediadata_model.dart';

class MusicPlayerState extends ChangeNotifier {
  int currentIndex = 0;

  final audioPlayer = AudioPlayer();

  bool isPlaying = false; // Flag to track whether music is playing

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  Duration get currentPosition => _position;
  Duration get currentDuration => _duration;

  @override
  void dispose() {
    // Important: Remove the listener to prevent memory leaks
    // songListState.removeListener(_updateSongList);
    // audioPlayer.onPlayerStateChanged.listen(_onPlayerStateChanged).cancel();
    audioPlayer.onDurationChanged.listen(onDurationChanged).cancel();
    audioPlayer.onPositionChanged.listen(onPositionChanged).cancel();
    super.dispose();
  }

  void togglePlayback() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void onDurationChanged(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  void onPositionChanged(Duration newPosition) {
    _position = newPosition;
    notifyListeners();
  }

  String formatedDuration() {
    return formatTime(_duration);
  }

  Future setAudio(
      {required List<MediaModel> mediasList, required int currentIndex}) async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    String url = '${mediasList[currentIndex].fileUrl}';
    await audioPlayer.play(UrlSource(url));
    notifyListeners();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  void playNextMedia(
      {required List<MediaModel> mediasList, required int currentIndex}) {
    if (currentIndex == mediasList.last) {
      print('There is nothing to play next');
    } else if (currentIndex < mediasList.length - 1) {
      audioPlayer.stop();
      // currentIndex++;
      setAudio(mediasList: mediasList, currentIndex: currentIndex);
      notifyListeners();
    }
  }

  void playPreviousMedia(
      {required List<MediaModel> mediasList, required int currentIndex}) {
    if (currentIndex > 0) {
      // currentIndex--;
      setAudio(mediasList: mediasList, currentIndex: currentIndex);
      notifyListeners();
    }
  }
}
