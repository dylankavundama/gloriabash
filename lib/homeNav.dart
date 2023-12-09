import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gloriabash/Screen/homePage.dart';
import 'package:gloriabash/Video/HomeVideo.dart';
import 'package:gloriabash/about/about.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import '../Audio/main.dart';

// ignore: camel_case_types
class homeNav extends StatefulWidget {
  const homeNav({Key? key}) : super(key: key);

  @override
  State<homeNav> createState() => _homeNavState();
}

class _homeNavState extends State<homeNav> {
  List<Tab> tablist = const [
        Tab(
      icon: FaIcon(
        FontAwesomeIcons.music,
        size: 15,
        color: Colors.white,
      ),
    ),
    Tab(
      icon: FaIcon(
        FontAwesomeIcons.intercom,
        size: 15,
        color: Colors.white,
      ),
    ),
    Tab(
      icon: FaIcon(
        FontAwesomeIcons.video,
        size: 15,
        color: Colors.white,
      ),
    ),

    Tab(
      icon: FaIcon(
        FontAwesomeIcons.info,
        size: 15,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Text(
              "Gloria Bash",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          actions: [
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () async {
                const url =
                    'https://play.google.com/store/apps/details?id=com.gloriabash';
                Share.share(
                    "Telecharger l'Application de Gloria Bash #La PATRONA \n$url");
              },
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15,
                child: Center(
                  child: Icon(
                    Icons.share,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
          bottom: TabBar(
              tabs: tablist
                  .map((e) => Tab(
                        icon: e.icon,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
                    MyApp(),
          const homePage(),
          const HomeVideo(),

          const About()
        ]),
      ),
    );
  }
}
