class Post {
  late String uid;
  late String fullName;
  late String id;
  late String postImage;
  late String caption;
  late String createdDate;
  late bool isLiked;
  late bool isMine;
  String? imageUser;

  Post({
    required this.uid,
    required this.id,
    required this.postImage,
    required this.caption,
    required this.createdDate,
    required this.isLiked,
    required this.isMine,
    required this.fullName,
    this.imageUser,
  });

  Post.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    fullName = json["fullName"];
    id = json["id"];
    postImage = json["postImage"];
    caption = json["caption"];
    createdDate = json["createdDate"];
    isLiked = json["isLiked"];
    isMine = json["isMine"];
    imageUser = json["imageUser"];
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "fullName": fullName,
    "id": id,
    "postImage": postImage,
    "caption": caption,
    "createdDate": createdDate,
    "isLiked": isLiked,
    "isMine": isMine,
    "imageUser": imageUser,
  };
}