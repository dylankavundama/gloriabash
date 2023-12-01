import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.screenW,
    required this.screenH,
    required this.date,
    required this.description,
    required this.image,
    required this.titre,
    required this.categories,
    required this.index,
    required this.par,
  }) : super(key: key);

  final double screenW;
  final double screenH;
  final String image;
  final String titre;
  final String description;
  final String date;
  final String categories;
  final int index;
  final String par;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    Divider(
      color: Colors.blue.shade400,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.start,
            '${widget.titre}',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.assetNetwork(
            height: screenH * 0.3,
            width: screenW,
            placeholder: 'assets/a.jpg',
            image: 'https://tcnasbl.org/apn/postimages/${widget.image}',
            fit: BoxFit.cover,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }
}
