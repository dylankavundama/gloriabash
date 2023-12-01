import 'package:flutter/material.dart';
import 'package:gloriabash/Navbar.dart';
import 'package:gloriabash/Widget/Video/listVideo.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  
  runApp(const gloriabash());
}

class gloriabash extends StatelessWidget {
  const gloriabash({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: 
     HomePage(),
        
        );
  }
}
