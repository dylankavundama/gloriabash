import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gloriabash/Screen/Detail.dart';
import 'package:gloriabash/Screen/Stories.dart';
import '../Widget/showcarousel.dart';
import '../Widget/Post.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:google_mobile_ads/google_mobile_ads.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenH * 0.01),
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
