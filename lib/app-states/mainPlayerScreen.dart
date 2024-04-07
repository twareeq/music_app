// import 'package:flutter/material.dart';
// import 'package:music_app/app-states/smallMusicPlayerState.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
//
// import 'mediaPlayingState.dart';
//
// class MusicPlayerScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaPlayerModel = Provider.of<MusicPlayerState>(context);
//     context.watch<MusicPlayerState>().audioPlayer.onDurationChanged.listen((value) => mediaPlayerModel.onDurationChanged(value));
//     context.watch<MusicPlayerState>().audioPlayer.onPositionChanged.listen((value) => mediaPlayerModel.onPositionChanged(value));
//
//     return SlidingUpPanel(
//         panel: SmallMusicPlayer(), // Small music player UI
//         minHeight: 64,
//         maxHeight: MediaQuery.of(context).size.height,
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               '',
//               fit: BoxFit.cover,
//             ),
//             backgroundFilter,
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20.0,
//                 vertical: 50.0,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '',
//                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '',
//                     maxLines: 2,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall!
//                         .copyWith(color: Colors.white),
//                   ),
//                   const SizedBox(height: 30),
//
//                   mySlider,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '',
//                         ),
//                         Text(
//                           '',
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//
//                         }, // Implement Previous Song functionality
//                         icon: const Icon(
//                           Icons.skip_previous,
//                           color: Colors.white,
//                           size: 45,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           isPlaying ? Icons.pause_circle : Icons.play_circle,
//                           color: Colors.white,
//                           size: 45,
//                         ),
//                         onPressed: () async {
//                           PageNavController(
//                             mediasList: widget.mediasList,
//                             currentIndex: widget.currentIndex,
//                           );
//                           if (isPlaying) {
//                             await widget.audioPlayer.pause();
//                           } else {
//                             setAudio();
//                           }
//                           setState(() {
//                             isPlaying = !isPlaying;
//                           });
//                         },
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _playNextMedia();
//                         },
//                         icon: const Icon(
//                           Icons.skip_next,
//                           color: Colors.white,
//                           size: 45,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // BOTTOM ROW
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         iconSize: 35,
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.settings,
//                           color: Colors.white,
//                         ),
//                       ),
//                       IconButton(
//                         iconSize: 35,
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.repeat_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }
