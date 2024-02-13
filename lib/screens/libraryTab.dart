import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/song_playing_screen.dart';

import '../models/song_model.dart';

class LibraryTabScreen extends StatefulWidget {
  const LibraryTabScreen({super.key});

  @override
  State<LibraryTabScreen> createState() => _LibraryTabScreenState();
}

class _LibraryTabScreenState extends State<LibraryTabScreen> {
  List<SongModel> songs = SongModel.songs;
  int currentSong = 0;
  final audioPlayer = AudioPlayer();
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        var songObj = songs[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: _ListSongCard(
                            songObj: songObj,
                            song: songs[index],
                            currentSong: index,
                            audioPlayer: audioPlayer,
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListSongCard extends StatelessWidget {
  const _ListSongCard({
    required this.songObj,
    required this.song,
    required this.currentSong,
    required this.audioPlayer,
  });

  final SongModel songObj;
  final SongModel song;
  final int currentSong;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.asset(
          songObj.coverUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            songObj.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(songObj.artist),
        ],
      ),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        // Get.toNamed('/song', arguments: song);
        Get.to(
          SongPlayingScreen(
            song: song,
            currentSong: currentSong,
            audioPlayer: audioPlayer,
            onTap: () {},
          ),
        );
      },
    );
  }
}
