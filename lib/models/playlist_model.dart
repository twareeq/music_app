import 'song_model.dart';

class Playlist {
  final String category;
  final List<SongModel> songs;
  final String imageUrl;

  Playlist({
    required this.category,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
      category: 'Testimonies',
      songs: SongModel.songs,
      imageUrl:
          'assets/images/cover.jpeg',
    ),
    Playlist(
      category: 'Sermons',
      songs: SongModel.songs,
      imageUrl:
          'assets/images/hiphop.jpeg',
    ),
    Playlist(
      category: 'Songs',
      songs: SongModel.songs,
      imageUrl:
          'assets/images/gospel.jpeg',
    )
  ];
}
