import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/config/api_service.dart';
import 'package:music_app/models/api_models/mediadata_model.dart';

import '../../widgets/medias_list_view.dart';

class TestmonyLibraryTab extends StatefulWidget {
  const TestmonyLibraryTab({super.key});

  @override
  State<TestmonyLibraryTab> createState() => _TestmonyLibraryTabState();
}

class _TestmonyLibraryTabState extends State<TestmonyLibraryTab> {
  List<MediaModel> testmonyList = [];
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    gettingSermons();
    super.didChangeDependencies();
  }

  Future<void> gettingSermons() async {
    testmonyList = await APIHandler.getMediasByCategory(categoryId: 3);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gettingSermons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    itemCount: testmonyList.length,
                    itemBuilder: (context, index) {
                      var sermonObj = testmonyList[index];

                      return MediasListView(
                        mediaObj: sermonObj,
                        mediaList: testmonyList,
                        audioPlayer: audioPlayer,
                        currentIndex: index,
                        onTapped: () {},
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
