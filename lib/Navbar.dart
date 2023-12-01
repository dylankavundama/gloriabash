import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gloriabash/about/about.dart';
import 'package:gloriabash/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import '../Audio/main.dart';
import '../Widget/Video/listVideo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tab> tablist = const [
    Tab(
      icon: FaIcon(
        FontAwesomeIcons.home,
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
        FontAwesomeIcons.music,
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
          //   elevation: 0,
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
                    "Telecharger l'application de Gloria Bash #La PATRONA \n$url");
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
          const ScreenWelcome(),
          const ListVideo(),
          MyApp(),
          const About()
        ]),
      ),
    );
  }
}