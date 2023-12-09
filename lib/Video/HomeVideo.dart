import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gloriabash/Video/VideoLecture.dart';
import 'package:gloriabash/Widget/VideoWidget.dart';
import 'package:http/http.dart' as http;

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
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
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : SingleChildScrollView(
            padding: EdgeInsets.only(top: 3),
              child: Column(
                children: List.generate(
                  video.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoLecture(
                            titre: video[index]['PostTitle'],
                            videos: video[index]['PostDetails'],
                          ),
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
            ),
    );
  }
}
