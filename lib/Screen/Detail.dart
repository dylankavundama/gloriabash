import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gloriabash/Widget/Post.dart';
import 'package:http/http.dart' as http;
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
          padding: const EdgeInsets.only(top: 27),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: ScreenHeight * 0.4,
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
                                children: const [
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20,
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
                      color: Colors.white,
                      child: Text(
                        '${widget.tit}',
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenHeight * 0.03,
              ),
              Container(
                height: ScreenHeight * 0.06,
                width: ScreenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Date de publication ${widget.date}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            Text(
                              'Le ${widget.date}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.detail}',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 19,
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
