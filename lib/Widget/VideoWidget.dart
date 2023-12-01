import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Stack(
              children: [
                // Image.network(
                //   '${image}',
                //   fit: BoxFit.cover,

                // ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.assetNetwork(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    placeholder: 'assets/a.jpg',
                    image: '${image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.1,
                  width: screenWidth / 1,
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.black,
                      ),
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
    );
  }
}
