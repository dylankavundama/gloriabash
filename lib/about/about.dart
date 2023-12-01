import 'dart:ui';

import 'package:gloriabash/about/cnt.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gloriabash/about/info.dart';
import 'package:gloriabash/about/policy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MaterialApp(
    home: About(),
  ));
}

/// A simple app that loads a rewarded ad.
class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  final CountdownTimer _countdownTimer = CountdownTimer(10);
  //var _showWatchVideoButton = false;
  //var _coins = 0;
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/4191692802'
      : 'ca-app-pub-7329797350611067/4191692802';
//Id app ca-app-pub-3940256099942544~3347511713
  @override
  void initState() {
    super.initState();

    _countdownTimer.addListener(() => setState(() {
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            // ignore: avoid_print
          });
        }));
    _startNewGame();
  }

  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              onTap: () async {
                const url =
                    'https://play.google.com/store/apps/details?id=com.gloriabash';
                Share.share(
                    "Telecharger l'Application de Gloria Bash #La PATRONA \n$url");
              },
              title: const Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => info()),
                );
              },
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch(
                    'https://play.google.com/store/apps/details?id=com.gloriabash');
              },
              title: const Text(
                'Comment',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.add_comment,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => policy()),
                );
              },
              title: const Text(
                'Policy',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.key,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch('https://www.linkedin.com/in/dylan-kavundama-61b34a208');
              },
              title: const Text(
                'Developper',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch(
                    'https://play.google.com/store/apps/details?id=com.gloriabash');
              },
              title: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.update,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onWillPop: () => _onPressButon(context),
    );
  }

  void _loadAd() {
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

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }
}

Future<bool> _onPressButon(BuildContext context) async {
  bool? ext = await showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(title: const Text('Exit App'), actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes"),
          ),
        ]);
      });

  return ext ?? false;
}
