class SongBook {
  final String songName;
  final String verse;
  final String choras;

  SongBook({required this.songName, required this.verse, required this.choras});

  static List<SongBook> songBook = [
    SongBook(
        songName: 'songName',
        verse: 'hello from the other side',
        choras: 'kdjsld'),
    SongBook(
        songName: 'songName',
        verse: 'hello from the other side',
        choras: 'kdjsld'),
    SongBook(
        songName: 'songName',
        verse: 'hello from the other side',
        choras: 'kdjsld'),
    SongBook(
        songName: 'songName',
        verse: 'hello from the other side',
        choras: 'kdjsld'),
  ];
}
