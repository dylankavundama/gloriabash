import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gloriabash/DetailPost.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gloriabash/json/postJson.dart';
import '../showcarousel.dart';
import 'Widget/Post/Post.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MaterialApp(
    home: ScreenWelcome(),
  ));
}

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({Key? key}) : super(key: key);

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  List<dynamic> post = [];
  bool _isLoading = false;

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    const url = 'https://tcnasbl.org/apn/Vpost.php';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final resultat = jsonDecode(reponse.body);
    post = resultat;
    debugPrint(reponse.body);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchPosts();
  }

  BannerAd? _bannerAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/9692748148'
      : 'ca-app-pub-7329797350611067/9692748148';

  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.initState();
    _loadAd();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SingleChildScrollView(
                            child: CarouselSlider(
                          items: stories
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ShowCarouselPage(
                                        img: e.img,
                                      );
                                    }));
                                  },
                                  child: Image.asset(
                                    e.img,
                                    height: screenHeight * 0.38,
                                    width: screenWidth,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(autoPlay: true),
                        )),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenH * 0.04),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                post.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailPost(
                                        tit: post[index]['PostTitle'],
                                        img: post[index]['PostImage'],
                                        detail: post[index]['PostDetails'],
                                        date: post[index]['PostingDate'],
                                        postedBy: post[index]['postedBy'],
                                      );
                                    }));
                                  },
                                  child: PostWidget(
                                    screenW: screenW,
                                    screenH: screenH,
                                    categories: 'POLITIQUE',
                                    description: post[index]['PostDetails'],
                                    date: post[index]['PostingDate'],
                                    index: index + 1,
                                    titre: post[index]['PostTitle'],
                                    image: post[index]['PostImage'],
                                    par: post[index]['postedBy'],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
