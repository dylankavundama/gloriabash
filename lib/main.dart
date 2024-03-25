import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gloriabash/homeNav.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  OneSignal.shared.setAppId("c2f6248a-3c61-4381-a341-c6aa815cca8d");
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {});
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const gloriabash());
}

// ignore: camel_case_types
class gloriabash extends StatelessWidget {
  const gloriabash({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bash',
      theme: ThemeData(accentColor: Colors.white),
      home: const homeNav(),
    );
  }
}
