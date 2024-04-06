import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app-states/songListState.dart';
import 'package:provider/provider.dart';

import '../app-states/mediaPlayingState.dart';
import '../controller/navBarController.dart';

class MusicPlayerScreenTest extends StatelessWidget {
  MusicPlayerScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaPlayerModel = Provider.of<MusicPlayerState>(context);
    context.watch<MusicPlayerState>().audioPlayer.onDurationChanged.listen((value) => mediaPlayerModel.onDurationChanged(value));
    context.watch<MusicPlayerState>().audioPlayer.onPositionChanged.listen((value) => mediaPlayerModel.onPositionChanged(value));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            '${context.watch<MusicPlayerState>().songListState.mediasList[mediaPlayerModel.currentIndex].imageUrl}',
            fit: BoxFit.cover,
          ),
          const _BackgroundFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.watch<MusicPlayerState>().songListState.mediasList[mediaPlayerModel.currentIndex].title}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${context.watch<MusicPlayerState>().songListState.mediasList[mediaPlayerModel.currentIndex].categoryName}',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 30),

                Slider(
                    min: 0,
                    max: context
                        .watch<MusicPlayerState>()
                        .currentDuration
                        .inSeconds
                        .toDouble(),
                    value: context
                        .watch<MusicPlayerState>()
                        .currentPosition
                        .inSeconds
                        .toDouble(),
                    onChanged: ((value) async {
                      final position = Duration(seconds: value.toInt());
                      mediaPlayerModel.onPositionChanged(position);
                      await mediaPlayerModel.audioPlayer.seek(position);
                    })),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.watch<MusicPlayerState>().formatTime(mediaPlayerModel.currentPosition),
                      ),
                      Text(
                        context.watch<MusicPlayerState>().formatedDuration(),

                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        mediaPlayerModel.playPreviousMedia();
                      }, // Implement Previous Song functionality
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        mediaPlayerModel.isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Colors.white,
                        size: 45,
                      ),
                      onPressed: () async {
                        PageNavController(
                          mediasList: mediaPlayerModel.songListState.mediasList,
                          currentIndex: mediaPlayerModel.currentIndex,
                        );
                        if (mediaPlayerModel.isPlaying) {
                          await mediaPlayerModel.audioPlayer.pause();
                        } else {
                          mediaPlayerModel.setAudio();
                        }
                        mediaPlayerModel.togglePlayback();
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        mediaPlayerModel.playNextMedia();
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ],
                ),
                // BOTTOM ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 35,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      iconSize: 35,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.repeat_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
      ),
    );
  }
}
