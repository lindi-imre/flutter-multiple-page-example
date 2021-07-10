class Song {
  late final String url;
  late final String name;
  late final String artist;
  late final String icon;
  late final String album;
  late final Duration duration;
  Song(
      {required this.url, required this.name, required this.artist, required this.icon, required this.album, required this.duration});
}

List<Song> songList = [
  Song(url: "https://s5.radio.co/s0ec7c069a/listen",
      name: "Cool Radio NYC",
      artist: "High quality",
      icon: "http://www.steamngo.infora.hu/mobile_friendly.png",
      album: "http://www.steamngo.infora.hu/mobile_friendly.png",
      duration: Duration(minutes: 5, seconds: 7)),
  Song(url: "https://s5.radio.co/s0ec7c069a/low",
      name: "Cool Radio NYC",
      artist: "Low quality",
      icon: "http://www.steamngo.infora.hu/mobile_friendly.png",
      album: "http://www.steamngo.infora.hu/mobile_friendly.png",
      duration: Duration(minutes: 5, seconds: 7))
];

List<Song> testList = [
  Song(url: "https://www.offbeatbudapest.com/top10/best-trendy-restaurant-budapest/",
      name: "Teszt hirdetés1",
      artist: "High quality",
      icon: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
      album: "http://www.steamngo.infora.hu/mobile_friendly.png",
      duration: Duration(minutes: 5, seconds: 7)),
  Song(url: "https://www.offbeatbudapest.com/top10/best-trendy-restaurant-budapest/",
      name: "Teszt hirdetés 2",
      artist: "Low quality",
      icon: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
      album: "http://www.steamngo.infora.hu/mobile_friendly.png",
      duration: Duration(minutes: 5, seconds: 7)),
  Song(url: "https://www.offbeatbudapest.com/top10/best-trendy-restaurant-budapest/",
      name: "Teszt hirdetés 2",
      artist: "Low quality",
      icon: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
      album: "http://www.steamngo.infora.hu/mobile_friendly.png",
      duration: Duration(minutes: 5, seconds: 7))
];