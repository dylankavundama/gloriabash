import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gloriabash/about/cnt.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'player/PlayingControls.dart';
import 'player/PositionSeekWidget.dart';
import 'player/SongsSelector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  runApp(
    NeumorphicTheme(
      theme: const NeumorphicThemeData(
        baseColor: Colors.black87,
        intensity: 0.0,
        lightSource: LightSource.topLeft,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio(
      'assets/audios/Love Taste.m4a',
      metas: Metas(
        title: 'Love Taste',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Koleya Money.m4a',
      metas: Metas(
        title: 'Koleya Money',
        image: MetasImage.asset('assets/bb.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Alakini.m4a',
      metas: Metas(
        title: 'Alakini',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      ''
      'assets/audios/War.m4a',
      metas: Metas(
        title: 'War',
        image: MetasImage.asset('assets/c.jpg'),
      ),
    ),
    Audio(
      'assets/audios/ife.m4a',
      metas: Metas(
        title: 'ifé',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/fils de joie Cover.m4a',
      metas: Metas(
        title: 'fils de joie Cover',
        image: MetasImage.asset('assets/bb.jpg'),
      ),
    ),
    Audio(
      'assets/audios/BUGA.mp3',
      metas: Metas(
        title: 'BUGA',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/SL rumba drill Cover.m4a',
      metas: Metas(
        title: 'SL rumba drill Cover',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Fally Ipupa 100 Cover.m4a',
      metas: Metas(
        title: 'Fally Ipupa 100 Cover',
        image: MetasImage.asset('assets/bb.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Fally Ipupa Dis-moi COVER.m4a',
      metas: Metas(
        title: 'Fally Ipupa Dis-moi COVER',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Rush - People Mashup.m4a',
      metas: Metas(
        title: 'Rush - People Mashup',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Ckay  Emiliana - cover.m4a',
      metas: Metas(
        title: 'Ckay  Emiliana - cover',
        image: MetasImage.asset('assets/c.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
    _countdownTimer.addListener(() => setState(() {
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            // ignore: avoid_print
          });
        }));
    _startNewGame();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    _rewardedAd?.dispose();
    _countdownTimer.dispose();

    _bannerAd?.dispose();

    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  final CountdownTimer _countdownTimer = CountdownTimer(100);

  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5705877032'
      : 'ca-app-pub-7329797350611067/5705877032';

      //'ca-app-pub-7329797350611067/4191692802'

  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  BannerAd? _bannerAd;

  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7630097138'
      : 'ca-app-pub-7329797350611067/7630097138';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      StreamBuilder<Playing?>(
                          stream: _assetsAudioPlayer.current,
                          builder: (context, playing) {
                            if (playing.data != null) {
                              final myAudio = find(
                                  audios, playing.data!.audio.assetAudioPath);
                              print(playing.data!.audio.assetAudioPath);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: const NeumorphicStyle(
                                    //  color: Colors.black,
                                    depth: 8,
                                    surfaceIntensity: 1,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  child: myAudio.metas.image?.path == null
                                      ? const SizedBox()
                                      : myAudio.metas.image?.type ==
                                              ImageType.network
                                          ? Image.network(
                                              myAudio.metas.image!.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            )
                                          : Image.asset(
                                              myAudio.metas.image!.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            ),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing? playing) {
                    return Column(
                      children: <Widget>[
                        _assetsAudioPlayer.builderLoopMode(
                          builder: (context, loopMode) {
                            return PlayerBuilder.isPlaying(
                                player: _assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  return PlayingControls(
                                    loopMode: loopMode,
                                    isPlaying: isPlaying,
                                    isPlaylist: true,
                                    onStop: () {
                                      _assetsAudioPlayer.stop();
                                    },
                                    toggleLoop: () {
                                      _assetsAudioPlayer.toggleLoop();
                                    },
                                    onPlay: () {
                                      _assetsAudioPlayer.playOrPause();
                                    },
                                    onNext: () {
                                      //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                      _assetsAudioPlayer.next(
                                          keepLoopMode:
                                              true /*keepLoopMode: false*/);
                                    },
                                    onPrevious: () {
                                      _assetsAudioPlayer.previous(
                                          /*keepLoopMode: false*/);
                                    },
                                  );
                                });
                          },
                        ),
                        _assetsAudioPlayer.builderRealtimePlayingInfos(
                            builder: (context, RealtimePlayingInfos? infos) {
                          if (infos == null) {
                            return SizedBox();
                          }
                          //print('infos: $infos');
                          return Column(
                            children: [
                              PositionSeekWidget(
                                currentPosition: infos.currentPosition,
                                duration: infos.duration,
                                seekTo: (to) {
                                  _assetsAudioPlayer.seek(to);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeumorphicButton(
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: -10));
                                    },
                                    child: Text('-10'),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  NeumorphicButton(
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: 10));
                                    },
                                    child: const Text('+10'),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  if (_bannerAd != null)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SafeArea(
                                        child: SizedBox(
                                          width:
                                              _bannerAd!.size.width.toDouble(),
                                          height:
                                              _bannerAd!.size.height.toDouble(),
                                          child: AdWidget(ad: _bannerAd!),
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              // Text("jffffffffffffffff",style: TextStyle(color: Colors.red),),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing? playing) {
                    return SongsSelector(
                      audios: audios,
                      onPlaylistSelected: (myAudios) {
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: const AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );
                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: const NotificationSettings(),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadAd() {
    BannerAd(
      adUnitId: _adUnitIdd,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
    setState(() {
      RewardedAd.load(
          adUnitId: _adUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          }, onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('RewardedAd failed to load: $error');
          }));
    });
  }
}
