import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/libraryTabController.dart';
import 'package:music_app/models/local_app_models/playlist_model.dart';
import 'package:music_app/widgets/discovered_media.dart';
import 'package:provider/provider.dart';

import '../../config/app-states/songListState.dart';
import '../../models/api_models/mediadata_model.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Playlist> playlists = Playlist.playlists;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Welcome",
            textAlign: TextAlign.left,
          ),
        ),
        // bottomNavigationBar: const _CustomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              const _DiscoverMusic(),
              // Recently Added Section
              const MyGridView(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SectionHeader(title: 'Playlists'),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        return PlaylistCard(playlist: playlists[index]);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentlyAdded extends StatelessWidget {
  const _RecentlyAdded({
    required this.mediaList,
    required this.currentSong,
    required this.audioPlayer,
  });

  // final List<SongModel> songs;
  final List<MediaModel> mediaList;
  final int currentSong;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: SectionHeader(
              title: 'Categories',
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mediaList.length,
              itemBuilder: (context, index) {
                return SongCard(
                  media: mediaList[index],
                  currentSong: currentSong,
                  audioPlayer: audioPlayer,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        readOnly: true,
        cursorHeight: 15,
        style: const TextStyle(color: Colors.grey),
        onTap: () {
          Get.to(() => const DiscoveredMedia());
        },
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black54),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade400,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20.0),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1697081544011-e472e6a19cc8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}

// GRIDVIEW
class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      width: widthSize * 0.9,
      child: GridView.count(
        primary: false,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => const LibraryBarController(
                    initialTabIndex: 0,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 60, 80, 112),
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'All Songs',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(const LibraryBarController(
                initialTabIndex: 1,
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: const AssetImage('assets/images/glass.jpg'),
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'SERMONS',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(const LibraryBarController(
                initialTabIndex: 2,
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken),
                      image: const AssetImage('assets/images/pray.jpg')),
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'TESTIMONIES',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  image: const AssetImage('assets/images/illusions.jpg'),
                ),
                borderRadius: BorderRadius.circular(16)),
            child: const Center(
              child: Text(
                'SONGS',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
