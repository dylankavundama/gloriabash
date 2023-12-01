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
        Text(
          textAlign: TextAlign.justify,
          '${widget.titre}',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),

        Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          "${widget.description}",
          textAlign: TextAlign.justify,
          maxLines: 2,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        ),
        const Text(
          'Lire plus...',
          textAlign: TextAlign.justify,
          maxLines: 2,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: screenH * 0.01,
        ),

        Image.network(
          'https://tcnasbl.org/apn/postimages/${widget.image}',
          height: screenH * 0.4,
          width: screenW,
          fit: BoxFit.cover,
        ),
        //aad bouton shared
        const Padding(padding: EdgeInsets.only(top: 10))
      ],
    );
  }
}
