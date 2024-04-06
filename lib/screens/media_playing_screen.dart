import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/controller/navBarController.dart';
import '../mediasModule/models/mediadata_model.dart';

class MediaPlayingScreen extends StatefulWidget {
  List<MediaModel> mediasList;
  AudioPlayer audioPlayer;
  int currentIndex;

  MediaPlayingScreen(
      {required this.mediasList,
      required this.currentIndex,
      required this.audioPlayer,
      super.key});

  @override
  State<MediaPlayingScreen> createState() => _MediaPlayingScreenState();
}

class _MediaPlayingScreenState extends State<MediaPlayingScreen> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onPlayerStateChanged.listen(_onPlayerStateChanged);
    widget.audioPlayer.onDurationChanged.listen(_onDurationChanged);
    widget.audioPlayer.onPositionChanged.listen(_onPositionChanged);
  }

  @override
  void dispose() {
    widget.audioPlayer.onPlayerStateChanged.listen(_onPlayerStateChanged).cancel();
    widget.audioPlayer.onDurationChanged.listen(_onDurationChanged).cancel();
    widget.audioPlayer.onPositionChanged.listen(_onPositionChanged).cancel();
    super.dispose();
  }

  void _onPlayerStateChanged(PlayerState state) {
    setState(() {
      isPlaying = state == PlayerState.playing;
    });
  }

  void _onDurationChanged(Duration newDuration) {
    setState(() {
      duration = newDuration;
    });
  }

  void _onPositionChanged(Duration newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  Future setAudio() async {
    widget.audioPlayer.setReleaseMode(ReleaseMode.stop);

    String url = '${widget.mediasList[widget.currentIndex].fileUrl}';
    await widget.audioPlayer.play(UrlSource(url));
  }

  void _playNextMedia() {

    if (widget.currentIndex == widget.mediasList.last) {
      print('There is nothing to play next');
    } else if (widget.currentIndex < widget.mediasList.length - 1) {
      setState(() {
        widget.audioPlayer.stop();
        widget.currentIndex++;
      });
      setAudio();
    }
  }

  void _playPreviousMedia() {
    if (widget.currentIndex > 0) {
      setState(() {
        widget.currentIndex--;
      });
      setAudio();
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }


  @override
  Widget build(BuildContext context) {
    print('${widget.currentIndex}');
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
            '${widget.mediasList[widget.currentIndex].imageUrl}',
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
                  '${widget.mediasList[widget.currentIndex].title}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.mediasList[widget.currentIndex].categoryName}',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 30),

                Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: ((value) async {
                      final position = Duration(seconds: value.toInt());
                      await widget.audioPlayer.seek(position);
                    })),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                      ),
                      Text(
                        formatTime(duration),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _playPreviousMedia();
                      }, // Implement Previous Song functionality
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: Colors.white,
                        size: 45,
                      ),
                      onPressed: () async {
                        PageNavController(
                          mediasList: widget.mediasList,
                          currentIndex: widget.currentIndex,
                        );
                        if (isPlaying) {
                          await widget.audioPlayer.pause();
                        } else {
                          setAudio();
                        }
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        _playNextMedia();
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
