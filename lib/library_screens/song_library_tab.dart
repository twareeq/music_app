import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app-states/songListState.dart';
import 'package:provider/provider.dart';

import '../app-states/mediaPlayingState.dart';
import '../screens/musicPlayingScreenTest.dart';
import '../widgets/medias_scroll_view.dart';

class SongLibraryTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaPlayerModel = Provider.of<MusicPlayerState>(context);
    final songListModel = Provider.of<SongListState>(context);

    return Consumer<SongListState>(
      builder: (context, songListState, _) {
        // Check if mediasList is empty or data is not fetched yet
        if (songListState.mediasList.isEmpty) {
          // Fetching songs when the mediasList is empty
          // This ensures that songs are fetched only once, not on every rebuild
          // If songs are already fetched, this won't do anything
          print('Updating List!');
          songListState.gettingSongs();

          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  itemCount: songListState.mediasList.length,
                  itemBuilder: (context, index) {
                    var songObj = songListState.mediasList[index];
                    return MediasListView(
                      mediaObj: songObj,
                      mediaList: songListState.mediasList,
                      audioPlayer: mediaPlayerModel.audioPlayer,
                      currentIndex: index,
                      onTapped: () {
                        // songListModel.currentSongIndex = index;
                        songListModel.updateSongIndex(currentIndex: index);
                        Get.to(() => MusicPlayerScreenTest());
                      },
                    );
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
