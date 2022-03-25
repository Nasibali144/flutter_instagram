class Post {
  String uid = "";
  String fullName = "";
  String id = "";
  late String postImage;
  late String caption;
  String createdDate = "";
  bool isLiked = false;
  bool isMine = false;
  String? imageUser;

  Post({
    required this.postImage,
    required this.caption,
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