import 'dart:convert';
import 'dart:io';
import 'package:gloriabash/Widget/VideoWidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoLecture extends StatefulWidget {
  const VideoLecture({required this.videos, Key? key}) : super(key: key);
  final String videos;
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
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
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

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: screenH * 0.4,
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: screenH * 0.11,
          ),
          Stack(
            children: [
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
                ),
            ],
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
                        builder: (context) =>
                            VideoLecture(videos: video[index]['PostDetails']),
                      ));
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
          )
        ]),
      ),
    );
  }
}
