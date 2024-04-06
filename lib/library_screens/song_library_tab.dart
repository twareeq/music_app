import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/screens/media_playing_screen.dart';

import '../apimodule/api_service.dart';
import '../mediasModule/models/mediadata_model.dart';
import '../widgets/medias_scroll_view.dart';

class SongLibraryTabScreen extends StatefulWidget {
  const SongLibraryTabScreen({super.key});

  @override
  State<SongLibraryTabScreen> createState() => _SongLibraryTabScreenState();
}

class _SongLibraryTabScreenState extends State<SongLibraryTabScreen> {
  // List<SongModel> songs = SongModel.songs;
  List<MediaModel> songsList = [];
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    gettingSongs();
    super.didChangeDependencies();
  }

  Future<void> gettingSongs() async {
    songsList = await APIHandler.getMediasForSongs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gettingSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    itemCount: songsList.length,
                    itemBuilder: (context, index) {
                      var songObj = songsList[index];

                      return MediasListView(
                        mediaObj: songObj,
                        mediaList: songsList,
                        audioPlayer: audioPlayer,
                        currentIndex: index,
                        onTapped: () {
                          Get.to(() => MediaPlayingScreen(
                                mediasList: songsList,
                                currentIndex: index,
                                audioPlayer: audioPlayer,
                              ));
                        },
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
