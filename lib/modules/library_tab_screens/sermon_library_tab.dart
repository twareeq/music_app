import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/app-states/mediaPlayingState.dart';
import '../../utils/app-states/songListState.dart';
import '../../widgets/medias_scroll_view.dart';
import '../screens/media_player_screen.dart';

class SermonLibraryTab extends StatelessWidget {
  const SermonLibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaPlayerModel = Provider.of<MusicPlayerState>(context);
    final songListModel = Provider.of<SongListState>(context);

    return Consumer<SongListState>(
      builder: (context, songListState, _) {
        // Check if mediasList is empty or data is not fetched yet
        if (songListState.sermonsList.isEmpty) {
          // Fetching songs when the mediasList is empty
          // This ensures that songs are fetched only once, not on every rebuild
          // If songs are already fetched, this won't do anything
          print('Updating List!');
          songListState.gettingSermons();

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
                  itemCount: songListState.sermonsList.length,
                  itemBuilder: (context, index) {
                    var songObj = songListState.sermonsList[index];
                    return MediasListView(
                      mediaObj: songObj,
                      mediaList: songListState.mediasList,
                      audioPlayer: mediaPlayerModel.audioPlayer,
                      currentIndex: index,
                      onTapped: () {
                        // songListModel.currentSongIndex = index;
                        songListModel.updateSongIndex(currentIndex: index);
                        Get.to(() => const MusicPlayerScreenTest());
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
