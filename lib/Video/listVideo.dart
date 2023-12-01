import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gloriabash/Video/youtube.dart';
import 'video.dart';
import 'package:http/http.dart' as http;

class ListVideo extends StatefulWidget {
  const ListVideo({Key? key}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
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
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : SingleChildScrollView(
              child: Column(
                children:  List.generate(
                  video.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Youtube(videos: video[index]['PostDetails']),
                        ),
                      );
                    },
                    child: PostVideoWidget(
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
