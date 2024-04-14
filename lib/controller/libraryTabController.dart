import 'package:flutter/material.dart';
import 'package:music_app/library_screens/sermon_library_tab.dart';
import 'package:music_app/library_screens/song_library_tab.dart';
import 'package:music_app/library_screens/testmony_library_tab.dart';

class LibraryBarController extends StatefulWidget {
  final int initialTabIndex; // New required parameter

  const LibraryBarController({Key? key, required this.initialTabIndex})
      : super(key: key);

  @override
  State<LibraryBarController> createState() => _LibraryBarControllerState();
}

class _LibraryBarControllerState extends State<LibraryBarController>
    with TickerProviderStateMixin {
  late TabController controllerBar;
  int selectedTabBar = 0;

  @override
  void initState() {
    super.initState();

    controllerBar = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex, // Set initial index
    );

    controllerBar.addListener(() {
      setState(() {
        selectedTabBar = controllerBar.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerBar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              // ON TOP TABS
              SizedBox(
                height: 100,
                child: TabBar(
                  controller: controllerBar,
                  tabs: const [
                    Tab(
                      child: Text('Songs'),
                    ),
                    Tab(
                      child: Text('Sermons'),
                    ),
                    Tab(
                      child: Text('Testimonies'),
                    ),
                  ],
                ),
              ),
              // INSIDE TABS
              Expanded(
                child: TabBarView(
                  controller: controllerBar,
                  children: [
                    SongLibraryTabScreen(),
                    SermonLibraryTab(),
                    TestmonyLibraryTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
