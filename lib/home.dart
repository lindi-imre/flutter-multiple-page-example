import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tester_project/page/chat.dart';
import 'package:tester_project/page/marketing.dart';
import 'package:tester_project/page/player.dart';
import 'package:audio_service/audio_service.dart';
import 'package:tester_project/service/database.dart';

MediaItem mediaItem = MediaItem(
    id: songList[0].url,
    album: songList[0].name,
    title: songList[0].name,
    artUri: Uri.parse(songList[0].icon),
    artist: songList[0].artist);

int current = 0;

_backgroundTaskEntryPoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(
        controls: [
          MediaControl.stop
        ],
        playing: true,
        processingState: AudioProcessingState.connecting
    );

    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setMediaItem(mediaItem);

    _audioPlayer.play();
    AudioServiceBackground.setState(
        controls: [
          MediaControl.stop
        ],
        playing: true,
        processingState: AudioProcessingState.ready
    );

    return super.onStart(params);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        controls: [MediaControl.play],
        playing: false,
        processingState: AudioProcessingState.stopped
    );
    await _audioPlayer.stop();
    return super.onStop();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(
        controls: [MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready
    );

    await _audioPlayer.pause();

    return super.onPause();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(
        controls: [MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready
    );

    await _audioPlayer.play();

    return super.onPlay();
  }

  @override
  Future<void> onSkipToNext() async {
    if(current < songList.length-1 ) {
      current = current + 1;
    }
    else {
      current = 0;
    }
    String url = songList[0].icon;
    mediaItem = MediaItem(
        id: songList[current].url,
        album: songList[current].name,
        title: songList[current].name,
        artUri: Uri.parse(url),
        duration: songList[current].duration,
        artist: songList[current].artist);
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setState(position: Duration.zero);
    return super.onSkipToNext();
  }

  @override
  Future<void> onSkipToPrevious() async {
    if(current > 0) {
      current = current - 1;
    }
    else {
      current = songList.length - 1;
    }
    String url = songList[current].icon;
    mediaItem = MediaItem(
        id: songList[current].url,
        album: songList[current].name,
        title: songList[current].name,
        artUri: Uri.parse(url),
        duration: songList[current].duration,
        artist: songList[current].artist);
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setState(position: Duration.zero);
    return super.onSkipToNext();
  }
}

class Home extends StatefulWidget {

  var volume = 0.8;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const url = 'https://s5.radio.co/s0ec7c069a/listen';
  bool isPlaying = false;

  late AudioPlayer _audioPlayer;

  void _initPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(url);
  }

  void initState() {
    super.initState();
    AudioService.connect();
    _initPlayer();
  }

  int currentTab = 0;
  final List<Widget> screens = [Player(), Chat(), Marketing()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Player();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
        theme: new ThemeData.dark(),
        home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.2, 0.5, 0.85],
                      colors: [Colors.black12, Colors.black87, Colors.black12
                  ])),
              child: PageStorage(
                child: currentScreen,
                bucket: bucket,
              )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                if(isPlaying) {
                  _audioPlayer.stop();
                  isPlaying = false;
                }
                else {
                  _audioPlayer.play();
                  _audioPlayer.playerStateStream.listen((event) {
                    if(event.playing) {
                      isPlaying = true;
                    }
                  });
                }
              });
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            child: Container(
              height: screenHeight * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Player();
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_tethering,
                                color:
                                    currentTab == 0 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Chat();
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                color:
                                    currentTab == 1 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Marketing();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_rounded,
                                color:
                                    currentTab == 2 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Marketing();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.facebook,
                                color: currentTab == 3
                                    ? Colors.blue
                                    : Colors.grey),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
