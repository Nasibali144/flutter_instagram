import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/services/auth_service.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = "profile_page";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    items.addAll([
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User"),
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Profile", icon: Icon(Icons.exit_to_app, color: Colors.black87,), onPressed: () {
        AuthService.signOutUser(context);
      }),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // #avatar
            Stack(
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.purpleAccent, width: 2)),
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image(
                      image: AssetImage("assets/images/user.png"),
                      height: 50,
                    ),
                  ),
                ),
                Container(
                  height: 77.5,
                  width: 77.5,
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.purple,
                        )),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            // #name
            Text("Khurshidbek".toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),

            // #email
            Text("shamsun@gmail.com", style: TextStyle(color: Colors.black54, fontSize: 14),),
            SizedBox(height: 15,),

            // #statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      text: "675" + "\n",
                      children: [
                        TextSpan(
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                          text: "POST",
                        )
                      ]
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      text: "4,676" + "\n",
                      children: [
                        TextSpan(
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                          text: "FOLLOWERS",
                        )
                      ]
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      text: "897" + "\n",
                      children: [
                        TextSpan(
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                          text: "FOLLOWING",
                        )
                      ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            // #posts
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: items[index].postImage,
                        placeholder: (context, url) => Container(color: Colors.grey,),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Text(items[index].caption, textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                    ],
                  );
                }),
            ),
          ],
        ),
      ),
    );
  }
}
