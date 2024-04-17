import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/config/api_service.dart';
import 'package:music_app/widgets/medias_scroll_view.dart';

import '../models/api_models/mediadata_model.dart';

class DiscoveredMedia extends StatefulWidget {
  const DiscoveredMedia({super.key});

  @override
  State<DiscoveredMedia> createState() => _DiscoveredMediaState();
}

class _DiscoveredMediaState extends State<DiscoveredMedia> {
  List<MediaModel> allMedia = []; // Store all media fetched from API
  List<MediaModel> filteredMedia = []; // Store filtered media based on search
  final audioPlayer = AudioPlayer();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call your API to fetch media data
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    // Fetch media data from API
    List<MediaModel> mediaData =
        await APIHandler.getAllMedias(); // Example API call

    setState(() {
      allMedia = mediaData;
      filteredMedia = allMedia; // Initialize filtered media with all media
    });
  }

  void filterMedia(String query) {
    setState(() {
      if (query.isNotEmpty) {
        // Filter media based on title containing the query
        filteredMedia = allMedia.where((media) {
          return media.title!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        // If query is empty, show all media
        filteredMedia = allMedia;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            height: 40,
            child: TextField(
              controller: searchController,
              onChanged: filterMedia, // Call filter function on text change
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: filteredMedia.length,
            itemBuilder: (context, index) {
              return MediasListView(
                  mediaObj: filteredMedia[index],
                  mediaList: filteredMedia,
                  audioPlayer: audioPlayer,
                  currentIndex: index,
                  onTapped: () {});
            },
          ),
        ),
      ),
    );
  }
}
