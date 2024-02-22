import 'dart:convert';
import 'dart:io';
import 'package:gloriabash/Widget/VideoWidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoLecture extends StatefulWidget {
  const VideoLecture({required this.videos, required this.titre, Key? key})
      : super(key: key);
  final String videos;
  final String titre;
  @override
  State<VideoLecture> createState() => _VideoLectureState();
}

class _VideoLectureState extends State<VideoLecture> {
  late YoutubePlayerController controller;
  List<dynamic> video = [];
  bool _isLoading = false;
  fetchvideos() async {
    setState(() {
      _isLoading = true;
    });
    const url = 'https://tcnasbl.org/apn/Vvideo.php';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final resultat = jsonDecode(reponse.body);
    video = resultat;
    debugPrint(reponse.body);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchvideos();
    String url = widget.videos;
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
            hideControls: false,
            controlsVisibleAtStart: true,
            hideThumbnail: false,
            mute: false,
            loop: false,
            autoPlay: true));
  }

  @override
  void deactivate() {
    controller.pause();
  }
  BannerAd? _bannerAd;
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/9692748148'
      : 'ca-app-pub-7329797350611067/9692748148';
  @override
  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
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
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  bool _isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Vous Regarder ${widget.titre}',
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          SizedBox(
            height: screenH * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              video.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoLecture(
                          videos: video[index]['PostDetails'],
                          titre: video[index]['PostTitle']),
                    ),
                  );
                },
                child: VideoWidget(
                  screenHeight: screenH,
                  screenWidth: screenW,
     
                  // ignore: prefer_interpolation_to_compose_strings
                  image: "https://tcnasbl.org/apn/postimages/" +
                      video[index]['PostImage'],
                  titre: video[index]['PostTitle'],
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isFullScreen = !_isFullScreen;
            controller.toggleFullScreenMode();
          });
        },
        child: Icon(
          _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
