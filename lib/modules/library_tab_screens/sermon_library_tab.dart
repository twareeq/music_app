import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/providers/media_playing_state.dart';
import '../../utils/providers/song_list_state.dart';
import '../../widgets/medias_list_view.dart';
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
          dynamic dynamicModel = context
              .watch<SongListState>()
              .sermonsList[songListModel.currentSongIndex];
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
                      mediaList: songListState.sermonsList,
                      audioPlayer: mediaPlayerModel.audioPlayer,
                      currentIndex: index,
                      onTapped: () {
                        // songListModel.currentSongIndex = index;
                        songListModel.updateSongIndex(currentIndex: index);
                        songListModel.updateDynamicListModel(
                            dynamicList: dynamicModel);

                        Get.to(() => MediaPlayerScreen(
                              myList: songListModel.sermonsList,
                              listModel: songListModel.sermonsList,
                              currentSong: dynamicModel,
                            ));
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
