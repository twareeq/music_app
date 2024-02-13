class RecentSongs {
  final String title;
  final String artist;
  final String category;
  final String url;
  final String coverUrl;

  RecentSongs({
    required this.title,
    required this.artist,
    required this.category,
    required this.url,
    required this.coverUrl
  });

  static List<RecentSongs> recent = [
    RecentSongs(
      title: 'Glass',
      artist: 'Lil Durk',
      category: 'Songs',
      url: 'assets/music/glass.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    RecentSongs(
      title: 'Illusions',
      artist: 'Lil Durk',
      category: 'Songs',
      url: 'assets/music/illusions.mp3',
      coverUrl: 'assets/images/illusions.jpg',
    ),
    RecentSongs(
      title: 'Pray',
      artist: 'Namadingo',
      category: 'Sermons',
      url: 'assets/music/pray.mp3',
      coverUrl: 'assets/images/pray.jpg',
    ),
  ];

}