// import 'package:flutter/material.dart';
// import 'package:music_app/app-states/smallMusicPlayerState.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
//
// class MusicPlayerScreen extends StatelessWidget {
//   MusicPlayerScreen(this.imageUrl, this.title, this.categoryName);
//
//   final String imageUrl;
//   final String title;
//   final String categoryName;
//   final Widget backgroundFilter;
//   final Widget mySlider;
//   final String position;
//   final String duration;
//   final VoidCallbackAction prevPlay;
//   final VoidCallback nextPlay;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SlidingUpPanel(
//         panel: SmallMusicPlayer(), // Small music player UI
//         minHeight: 64,
//         maxHeight: MediaQuery.of(context).size.height,
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               imageUrl,
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
//                     title,
//                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     categoryName,
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
//                           position,
//                         ),
//                         Text(
//                           duration,
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
//                           prevPlay
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
