import 'package:flutter/material.dart';
import 'package:gloriabash/homeNav.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const gloriabash());
}

// ignore: camel_case_types
class gloriabash extends StatelessWidget {
  const gloriabash({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(accentColor: Colors.white),
      home: const homeNav(),
    );
  }
}
