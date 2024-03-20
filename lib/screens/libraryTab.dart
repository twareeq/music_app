import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/apimodule/api_service.dart';
import 'package:music_app/screens/song_playing_screen.dart';

import '../mediasModule/models/mediadata_model.dart';
import '../models/song_model.dart';

class LibraryTabScreen extends StatefulWidget {
  const LibraryTabScreen({super.key});

  @override
  State<LibraryTabScreen> createState() => _LibraryTabScreenState();
}

class _LibraryTabScreenState extends State<LibraryTabScreen> {
  List<SongModel> songs = SongModel.songs;
  List<MediaModel> mediaList = [];
  int currentSong = 0;
  final audioPlayer = AudioPlayer();
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getMedia();
    super.didChangeDependencies();
  }

  Future<void> getMedia() async {
    mediaList = await APIHandler.getMedias();
  }

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
                      itemCount: mediaList.length,
                      itemBuilder: (context, index) {
                        var mediasObj = mediaList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: _ListSongCard(
                            mediaObj: mediasObj,
                            media: mediasObj,
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
    required this.mediaObj,
    required this.media,
    required this.currentSong,
    required this.audioPlayer,
  });

  final MediaModel mediaObj;
  final MediaModel media;
  final int currentSong;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.asset(
          mediaObj.imageUrl!,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mediaObj.title!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Artist"),
        ],
      ),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        // Get.toNamed('/song', arguments: song);
        Get.to(
          SongPlayingScreen(
            media: media,
            currentSong: currentSong,
            audioPlayer: audioPlayer,
            onTap: () {},
          ),
        );
      },
    );
  }
}
