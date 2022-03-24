import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/auth_service.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/file_service.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = "profile_page";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  List<Post> items = [];
  File? _image;
  User? user;

  @override
  void initState() {
    super.initState();
    _apiLoadUser();
    items.addAll([
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User"),
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User")
    ]);
  }

  // for user image
  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });
    _apiChangePhoto();
  }

  _imgFromGallery() async {
    XFile? image = await  ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });
    _apiChangePhoto();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  // for load user
  void _apiLoadUser() async {
    setState(() {
      isLoading = true;
    });
    DataService.loadUser().then((value) => _showUserInfo(value));
  }

  void _showUserInfo(User user) {
    setState(() {
      this.user = user;
      isLoading = false;
    });
  }

  // for edit user
  void _apiChangePhoto() {
    if(_image == null) return;

    setState(() {
      isLoading = true;
    });
    FileService.uploadImage(_image!, FileService.folderUserImg).then((value) => _apiUpdateUser(value));
  }

  void _apiUpdateUser(String imgUrl) async{
    setState(() {
      isLoading = false;
      user!.imageUrl = imgUrl;
    });
    await DataService.updateUser(user!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Profile", icon: Icon(Icons.exit_to_app, color: Colors.black87,), onPressed: () {
        AuthService.deleteAccount(context);
      }),
      body: Stack(
        children: [
          Container(
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
                      width: 75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.purpleAccent, width: 2)),
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child:  user?.imageUrl == null || user!.imageUrl!.isEmpty ? const Image(
                          image: AssetImage("assets/images/user.png"),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ) : Image(
                          image: NetworkImage(user!.imageUrl!),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
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
                            onPressed: () {
                              _showPicker(context);
                            },
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
                Text(user == null ? "": user!.fullName.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),

                // #email
                Text(user == null ? "": user!.email, style: TextStyle(color: Colors.black54, fontSize: 14),),
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
                            text: user == null ? "0": user!.followersCount.toString() + "\n",
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
                        text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            text: user == null ? "0": user!.followingCount.toString() + "\n",
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

          if(isLoading) const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
