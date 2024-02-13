class SongModel {
  final String title;
  final String artist;
  final String category;
  final String url;
  final String coverUrl;

  SongModel(
      {required this.title,
      required this.artist,
      required this.category,
      required this.url,
      required this.coverUrl});

  static List<SongModel> songs = [
    SongModel(
      title: 'butterflies',
      artist: 'AJ Tracy',
      category: 'Songs',
      url: 'music/butter.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'dreamer',
      artist: 'Alarn Walker',
      category: 'Songs',
      url: 'music/dreamer.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Floss',
      artist: 'AJ Tracy',
      category: 'Songs',
      url: 'music/glass.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Prada Me',
      artist: 'AJ Tracy',
      category: 'Songs',
      url: 'music/prada.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Zelda',
      artist: 'Stareeh',
      category: 'Songs',
      url: 'music/zelda.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Psych Out!',
      artist: 'J Cole',
      category: 'Songs',
      url: 'music/psych.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Landbroke Grove',
      artist: 'Alarn Walker',
      category: 'Songs',
      url: 'music/grover.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Wifey Riddim',
      artist: 'Shensia',
      category: 'Songs',
      url: 'music/wifey.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Nothing But Net',
      artist: 'Deno',
      category: 'Songs',
      url: 'music/net.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Triple S',
      artist: 'Zain Dusk',
      category: 'Songs',
      url: 'music/tripple.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Rabel',
      artist: 'Shenseea',
      category: 'Songs',
      url: 'music/rabel.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Rina',
      artist: 'Vibes Catel',
      category: 'Songs',
      url: 'music/rina.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Glass',
      artist: 'Lil Durk',
      category: 'Songs',
      url: 'music/glass.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    SongModel(
      title: 'Illusions',
      artist: 'Lil Durk',
      category: 'Songs',
      url: 'music/illusions.mp3',
      coverUrl: 'assets/images/illusions.jpg',
    ),
    SongModel(
      title: 'Pray',
      artist: 'Namadingo',
      category: 'Sermons',
      url: 'music/pray.mp3',
      coverUrl: 'assets/images/pray.jpg',
    ),
  ];
}
