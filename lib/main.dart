import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app-states/mediaPlayingState.dart';
import 'package:music_app/controller/navBarController.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/musicPlayingScreenTest.dart';
import 'package:music_app/screens/playlist_screen.dart';
import 'package:provider/provider.dart';

import 'app-states/songListState.dart';

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final SongListState songListState = SongListState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: songListState), // Use value constructor to provide existing instance
        ChangeNotifierProvider(create: (_) => MusicPlayerState(songListState: songListState)),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music App',
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white
            )
        ),
        home: const PageNavController(),
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/playerPage', page: () => MusicPlayerScreenTest()),
          GetPage(name: '/playlist', page: () => const PlaylistScreen()),
        ],
      ),
    );
  }
}

