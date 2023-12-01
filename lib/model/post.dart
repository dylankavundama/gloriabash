class Post {
  final int idPost;
  final String categorie;
  final String img;
  final String title;
  final String description;
  final String date;
  final String source;

  Post(
      {required this.idPost,
      required this.categorie,
      required this.description,
      required this.date,
      required this.img,
      required this.title,
      required this.source});
}

class ImagePost {
  final int idImg;
  final String img;
  final int codePost;

  ImagePost({required this.idImg, required this.img, required this.codePost});
}

class Story {
  final int idStorie;
  final String img;

  Story({required this.idStorie, required this.img});
}
