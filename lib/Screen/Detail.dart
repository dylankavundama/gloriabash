import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gloriabash/Widget/Post.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'homePage.dart';

class DetailPost extends StatefulWidget {
  const DetailPost(
      {required this.img,
      required this.detail,
      required this.date,
      required this.tit,
      required this.postedBy,
      Key? key})
      : super(key: key);
  final String img;
  final String tit;
  final String detail;
  final String date;
  final String postedBy;
  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  List<dynamic> post = [];
  bool _isLoading = false;
  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    const url = 'https://tcnasbl.org/apn/Vpost.php';

    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final resultat = jsonDecode(reponse.body);
    post = resultat;
    debugPrint(reponse.body);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: ScreenHeight * 0.6,
                    width: ScreenWidth,
                    child: Image.network(
                      'https://tcnasbl.org/apn/postimages/${widget.img}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 8,
                    right: 8,
                    top: 18,
                    bottom: 16,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const homePage();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.arrow_left_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      const url =
                                          'https://play.google.com/store/apps/details?id=com.gloriabash';
                                      Share.share(
                                          "Telecharger l'Application de Gloria Bash #La PATRONA \n$url");
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenHeight * 0.2,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: ScreenHeight * 0.4,
                    left: 8,
                    right: 10,
                    child: Container(
                      color: Colors.white60,
                      child: Text(
                        '${widget.tit}',
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.detail}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: ScreenHeight * 0.02,
                      width: ScreenWidth * 0.3,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'AUTRE POST',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          post.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPost(
                                  tit: post[index]['PostTitle'],
                                  img: post[index]['PostImage'],
                                  detail: post[index]['PostDetails'],
                                  date: post[index]['PostingDate'],
                                  postedBy: post[index]['postedBy'],
                                );
                              }));
                            },
                            child: PostWidget(
                              screenW: ScreenWidth,
                              screenH: ScreenHeight,
                              categories: "PLAIDOIRIE",
                              description: post[index]['PostDetails'],
                              date: post[index]['PostingDate'],
                              index: index + 1,
                              titre: post[index]['PostTitle'],
                              image: post[index]['PostImage'],
                              par: post[index]['postedBy'],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
