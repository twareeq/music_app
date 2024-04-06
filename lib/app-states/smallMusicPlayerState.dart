import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mediaPlayingState.dart';

class SmallMusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerState>(
      builder: (context, musicPlayerState, _) {
        return Container(
          // Small music player UI
          height: 64,
          color: Colors.grey[200],
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  musicPlayerState.togglePlayback();
                },
              ),
              Text(
                musicPlayerState.isPlaying ? 'Now Playing' : 'Paused',
              ),
            ],
          ),
        );
      },
    );
  }
}
