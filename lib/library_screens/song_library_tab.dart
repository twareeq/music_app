import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/app-states/songListState.dart';
import 'package:provider/provider.dart';

import '../apimodule/api_service.dart';
import '../app-states/mediaPlayingState.dart';
import '../mediasModule/models/mediadata_model.dart';
import '../screens/musicPlayingScreenTest.dart';
import '../widgets/medias_scroll_view.dart';

class SongLibraryTabScreen extends StatefulWidget {
  const SongLibraryTabScreen({super.key});

  @override
  State<SongLibraryTabScreen> createState() => _SongLibraryTabScreenState();
}

class _SongLibraryTabScreenState extends State<SongLibraryTabScreen> {
  List<MediaModel> songsList = [];

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
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {

    final mediaPlayerModel = Provider.of<MusicPlayerState>(context);

    return FutureBuilder(
        future: context.watch<MusicPlayerState>().songListState.gettingSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    itemCount: context.read<MusicPlayerState>().songListState.mediasList.length,
                    itemBuilder: (context, index) {
                      var songObj = context.read<MusicPlayerState>().songListState.mediasList[index];
                      print(index);

                      return MediasListView(
                        mediaObj: songObj,
                        mediaList: context.read<MusicPlayerState>().songListState.mediasList,
                        audioPlayer: mediaPlayerModel.audioPlayer,
                        currentIndex: index,
                        onTapped: () {
                          mediaPlayerModel.currentIndex = index;
                          Get.to(() => MusicPlayerScreenTest());
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
