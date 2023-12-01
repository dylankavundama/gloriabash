import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  VideoApp({required this.img, Key? key});

  final String img;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.img)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : SingleChildScrollView(
              child: Column(
                children: [

                 
                  Stack(
                    children: [
                      Divider(
                        color: Colors.blue.shade400,
                      ),
                      Container(
                        height: screenHeight * 0.5,
                        child: _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ),
                      Positioned(
                        left: screenWidth * 0.85,
                        right: 0,
                        top: screenHeight * 0.4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blue.shade400,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Column(
                    children: [],
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class PostVideoWidget extends StatelessWidget {
  const PostVideoWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.image,
    required this.titre,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String image;
  final String titre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [


            Center(
              child: Stack(
                children: [
                  Image.network(
                    '${image}',
                    fit: BoxFit.cover,
                    height: screenHeight * 0.3,
                    width: screenWidth,
                  ),
                  Positioned(
                    top: screenHeight * 0.1,
                    width: screenWidth / 1,
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.play),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                        Container(
              color: Colors.black,
              height: screenHeight * 0.04,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titre,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
