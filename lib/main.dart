import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/utils/providers/media_playing_state.dart';
import 'package:music_app/controller/navBarController.dart';
import 'package:music_app/modules/screens/home_screen.dart';
import 'package:music_app/modules/screens/media_player_screen.dart';
import 'package:music_app/modules/screens/playlist_screen.dart';
import 'package:provider/provider.dart';

import 'utils/providers/song_list_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final SongListState songListState = SongListState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final mediaPlayerModel = Provider.of<MusicPlayerState>(context);

    // mediaPlayerModel.audioPlayer.setReleaseMode(ReleaseMode.release);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SongListState()),
        ChangeNotifierProvider(create: (_) => MusicPlayerState()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music App',
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: const PageNavController(),
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/playlist', page: () => const PlaylistScreen()),
        ],
      ),
    );
  }
}
