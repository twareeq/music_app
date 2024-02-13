import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';


import '../models/song_model.dart';

class SongPlayingScreen extends StatefulWidget {
  SongPlayingScreen(
      {required this.song,
      required this.currentSong,
      required this.audioPlayer,
        required this.onTap,
      super.key});

  SongModel song;
  AudioPlayer audioPlayer;
  int currentSong;
  VoidCallback onTap;

  @override
  State<SongPlayingScreen> createState() => _SongPlayingScreenState();
}

class _SongPlayingScreenState extends State<SongPlayingScreen> {
  Duration maxDuration = const Duration(seconds: 0);
  late ValueListenable<Duration> progress;
  List<SongModel> songs = SongModel.songs;

  @override
  void initState() {
    // TODO: implement initState
    widget.audioPlayer.play(AssetSource(songs[widget.currentSong % songs.length].url));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMaxDuration() {
      widget.audioPlayer.getDuration().then((value) {
        maxDuration = value ?? const Duration(seconds: 0);
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            songs[widget.currentSong % songs.length].coverUrl,
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
                  songs[widget.currentSong % songs.length].title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  songs[widget.currentSong % songs.length].category,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 30),
                StreamBuilder(
                  stream: widget.audioPlayer.onPositionChanged,
                  builder: (context, snapshot) => ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    buffered: Duration(milliseconds: 2000),
                    total: maxDuration,
                    onSeek: (duration) {
                      widget.audioPlayer.seek(duration);
                      setState(() {});
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.audioPlayer.stop();
                        widget.audioPlayer.play(AssetSource(
                            songs[--widget.currentSong % songs.length].url));
                        getMaxDuration();
                      },
                      // audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.audioPlayer.state == PlayerState.playing
                            ? widget.audioPlayer.pause()
                            : widget.audioPlayer.play(AssetSource(
                                songs[widget.currentSong % songs.length].url));
                        getMaxDuration();
                        setState(() {});
                      },
                      icon: Icon(
                        widget.audioPlayer.state == PlayerState.playing
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.audioPlayer.stop();
                        widget.audioPlayer.play(AssetSource(
                            songs[++widget.currentSong % songs.length].url));
                        getMaxDuration();
                      },
                      // audioPlayer.hasNext ? audioPlayer.seekToNext : null,
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
