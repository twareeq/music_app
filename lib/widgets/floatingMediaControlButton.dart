import 'package:flutter/material.dart';

class MediaControlButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isPlaying;
  final Function() onPreviousPressed;
  final Function() onPlayPausePressed;
  final Function() onNextPressed;

  const MediaControlButton({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.isPlaying,
    required this.onPreviousPressed,
    required this.onPlayPausePressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(isPlaying ? 'Playing' : 'Paused'),
            ],
          ),
          Spacer(),
          // IconButton(
          //   onPressed: onPreviousPressed,
          //   icon: Icon(Icons.skip_previous),
          // ),
          IconButton(
            onPressed: onPlayPausePressed,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            onPressed: onNextPressed,
            icon: const Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }
}
