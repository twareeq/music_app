import 'package:flutter/material.dart';
import 'package:music_app/screens/libraryTab.dart';

class LibraryBarController extends StatefulWidget {
  const LibraryBarController({super.key});

  @override
  State<LibraryBarController> createState() => _LibraryBarControllerState();
}

class _LibraryBarControllerState extends State<LibraryBarController>
    with TickerProviderStateMixin {
  TabController? controllerBar;
  int selectedTabBar = 0;

  @override
  void initState() {
    super.initState();

    controllerBar = TabController(length: 3, vsync: this);

    controllerBar?.addListener(() {
      selectedTabBar = controllerBar?.index ?? 0;

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    controllerBar?.dispose();
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
                child: TabBar(controller: controllerBar, tabs: const [
                  Tab(
                    child: Text('Songs'),
                  ),
                  Tab(
                    child: Text('Sermons'),
                  ),
                  Tab(
                    child: Text('Testimonies'),
                  ),
                ]),
              ),
              // INSIDE TABS
              Expanded(
                  child: TabBarView(
                    controller: controllerBar,
                    children: const [
                      LibraryTabScreen(),
                      Center(
                        child: Text('Sermons'),
                      ),
                      Center(
                        child: Text('Testimonies'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
