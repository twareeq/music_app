import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/config/api_service.dart';
import 'package:music_app/models/api_models/mediadata_model.dart';
import 'package:music_app/modules/screens/media_playing_screen.dart';

import '../../../widgets/medias_scroll_view.dart';

class SermonLibraryTab extends StatefulWidget {
  const SermonLibraryTab({super.key});

  @override
  State<SermonLibraryTab> createState() => _SermonLibraryTabState();
}

class _SermonLibraryTabState extends State<SermonLibraryTab> {
  List<MediaModel> sermonsList = [];
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
    gettingSermons();
    super.didChangeDependencies();
  }

  Future<void> gettingSermons() async {
    sermonsList = await APIHandler.getMediasForSermons();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gettingSermons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    itemCount: sermonsList.length,
                    itemBuilder: (context, index) {
                      var sermonObj = sermonsList[index];

                      return MediasListView(
                        mediaObj: sermonObj,
                        mediaList: sermonsList,
                        audioPlayer: audioPlayer,
                        currentIndex: index,
                        onTapped: () {
                          Get.to(() => MediaPlayingScreen(
                              mediasList: sermonsList,
                              currentIndex: index,
                              audioPlayer: audioPlayer));
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
