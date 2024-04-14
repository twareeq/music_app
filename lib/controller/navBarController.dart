import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/controller/libraryTabController.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/theTableScreen.dart';
import 'package:provider/provider.dart';

import '../app-states/mediaPlayingState.dart';
import '../app-states/songListState.dart';

class PageNavController extends StatefulWidget {
  const PageNavController({Key? key}) : super(key: key);

  @override
  State<PageNavController> createState() => _PageNavControllerState();
}

class _PageNavControllerState extends State<PageNavController>
    with TickerProviderStateMixin {
  TabController? controller;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller?.addListener(() {
      selectedTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaPlayerModel = Provider.of<MusicPlayerState>(context);
    final songListModel = Provider.of<SongListState>(context);
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          HomeScreen(),
          LibraryBarController(initialTabIndex: 0,),
          TheTable(),
        ],
      ),
      floatingActionButton: mediaPlayerModel.isPlaying ||
              mediaPlayerModel.audioPlayer.state == PlayerState.paused
          ? Container(
              height: 60,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.only(left: 28, bottom: 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 60,
                    margin: const EdgeInsets.only(left: 15, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              '${songListModel.mediasList[context.watch<SongListState>().currentSongIndex].imageUrl}'),
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      '${songListModel.mediasList[context.watch<SongListState>().currentSongIndex].title}'),
                  const SizedBox(
                    width: 100,
                  ),
                  IconButton(
                    icon: Icon(
                      mediaPlayerModel.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                    onPressed: () async {
                      const PageNavController();
                      if (mediaPlayerModel.isPlaying) {
                        await mediaPlayerModel.audioPlayer.pause();
                      } else {
                        mediaPlayerModel.setAudio(
                            mediasList: songListModel.mediasList,
                            currentIndex: songListModel.currentSongIndex);
                      }
                      mediaPlayerModel.togglePlayback();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      print(
                          'current index is ${context.read<SongListState>().currentSongIndex}');
                      //Figure Out which Index to Follow the one in the UI lost or the One in API
                      // songListModel.currentSongIndex =
                      //     mediaPlayerModel.currentIndex;
                      songListModel.playNextMedia(
                          currentIndex:
                              context.read<SongListState>().currentSongIndex);
                      mediaPlayerModel.playNextMedia(
                          mediasList: songListModel.mediasList,
                          currentIndex:
                              context.read<SongListState>().currentSongIndex);
                    },
                    icon: const Icon(
                      Icons.fast_forward,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      bottomNavigationBar: Container(
        height: 115,
        decoration:
            BoxDecoration(color: Colors.deepPurple.shade800, boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(0, -3))
        ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            dividerColor: Colors.transparent,
            controller: controller,
            indicator: const BoxDecoration(),
            indicatorWeight: 0,
            dividerHeight: 0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey,
            tabs: const [
              Tab(
                text: "Home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "library",
                icon: Icon(Icons.library_music),
              ),
              Tab(
                text: "song books",
                icon: Icon(Icons.table_chart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
