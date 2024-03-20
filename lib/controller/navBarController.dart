import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/apimodule/api_service.dart';
import 'package:music_app/controller/libraryTabController.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/song_playing_screen.dart';
import 'package:music_app/screens/theTableScreen.dart';

class PageNavController extends StatefulWidget {
  const PageNavController({super.key});

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
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          HomeScreen(),
          LibraryBarController(),
          TheTable(),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          APIHandler.getMedias();
        },
        child: Container(
          height: 60,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(left: 30.0, bottom: 0),
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
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/glass.jpg'),
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Artist - SongName'),
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
