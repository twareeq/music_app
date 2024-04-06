import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/apimodule/api_service.dart';
import 'package:music_app/controller/libraryTabController.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/media_playing_screen.dart';
import 'package:music_app/screens/theTableScreen.dart';

import '../mediasModule/models/mediadata_model.dart';

class PageNavController extends StatefulWidget {

  final List<MediaModel> mediasList;
  final int currentIndex;

  const PageNavController({
    required this.mediasList,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<PageNavController> createState() => _PageNavControllerState();
}

class _PageNavControllerState extends State<PageNavController>
    with TickerProviderStateMixin {
  TabController? controller;
  int selectedTab = 0;
  bool isOpened = false;

  List<MediaModel> mediasList = [];
  final audioPlayer = AudioPlayer();
  int currentMedia = 0;


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
  void didChangeDependencies() {
    gettingSongs();
    super.didChangeDependencies();
  }

  Future<void> gettingSongs() async {
    mediasList = await APIHandler.getMediasForSongs();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: TabBarView(
          controller: controller,
          children: const [
            HomeScreen(),
            LibraryBarController(),
            TheTable(),
          ],
        ),
        // bottomSheet: Container(
        //   height: 60,
        //   width: 370,
        //   margin: const EdgeInsets.only(bottom: 10),
        //   decoration: const BoxDecoration(
        //     color: Colors.deepPurpleAccent,
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //   ),
        //   child: Row(
        //     children: [
        //       Container(
        //         height: 35,
        //         width: 60,
        //         margin: const EdgeInsets.only(left: 15, bottom: 0),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8.0),
        //             image: const DecorationImage(
        //               fit: BoxFit.fill,
        //               image: NetworkImage('https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg'),
        //             ),),
        //       ),
        //       const SizedBox(
        //         width: 5,
        //       ),
        //       const Text('Song Name'),
        //       const SizedBox(
        //         width: 100,
        //       ),
        //       const Icon(Icons.play_arrow),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       const Icon(Icons.fast_forward_rounded),
        //     ],
        //   ),
        // ),

        floatingActionButton: Container(
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
                      image: NetworkImage('https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg'),
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Text('Song Name'),
              const SizedBox(
                width: 100,
              ),
              const Icon(Icons.play_arrow),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.fast_forward_rounded),
            ],
          ),
        ),

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
                  text: "table",
                  icon: Icon(Icons.table_chart),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
