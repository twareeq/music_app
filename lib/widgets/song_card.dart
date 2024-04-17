import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/modules/screens/media_playing_screen.dart';

import '../models/api_models/mediadata_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.media,
    required this.currentSong,
    required this.audioPlayer,
  });

  final MediaModel media;
  final int currentSong;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Get.toNamed('/song', arguments: song);
        Get.to(MediaPlayingScreen(
          mediasList: [],
          currentIndex: currentSong,
          audioPlayer: audioPlayer,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: AssetImage(media.imageUrl!), fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white.withOpacity(0.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        media.title!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        media.fileUrl!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
