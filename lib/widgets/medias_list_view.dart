import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/api_models/mediadata_model.dart';

// ignore: must_be_immutable
class MediasListView extends StatelessWidget {
  MediaModel mediaObj;
  List<MediaModel> mediaList;
  AudioPlayer audioPlayer;
  VoidCallback onTapped;
  int currentIndex;

  MediasListView(
      {required this.mediaObj,
      required this.mediaList,
      required this.audioPlayer,
      required this.currentIndex,
      required this.onTapped,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  '${mediaObj.imageUrl}',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${mediaObj.title}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${mediaObj.categoryName}')
                ],
              ),
              trailing: const Icon(Icons.more_vert),
              onTap: onTapped)),
    );
  }
}
