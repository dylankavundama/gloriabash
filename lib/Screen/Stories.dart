import 'package:flutter/material.dart';

class Story {
  final int idStorie;
  final String img;
  Story({required this.idStorie, required this.img});
}

List<Story> stories = [
  Story(idStorie: 1, img: 'assets/aa.jpg'),
  Story(idStorie: 1, img: 'assets/a.jpg'),
  Story(idStorie: 1, img: 'assets/b.jpg'),
  Story(idStorie: 1, img: 'assets/bb.jpg'),
  Story(idStorie: 1, img: 'assets/c.jpg'),
  Story(idStorie: 1, img: 'assets/cc.jpg'),
  Story(idStorie: 1, img: 'assets/dd.jpg'),
  Story(idStorie: 1, img: 'assets/e.jpg'),
  Story(idStorie: 1, img: 'assets/ee.jpg')
];

class StoryWidget extends StatefulWidget {
  const StoryWidget(
      {Key? key,
      required this.screenH,
      required this.screenW,
      required this.image})
      : super(key: key);

  final double screenH;
  final double screenW;
  final String image;

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.screenH * 0.2,
        width: widget.screenW * 0.3,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
              color: Colors.blue.shade400, style: BorderStyle.solid, width: 2),
        ),
        child: Image.network(
          widget.image,
          fit: BoxFit.cover,
          height: widget.screenH * 0.2,
          width: widget.screenW * 0.3,
        ),
      ),
    );
  }
}
