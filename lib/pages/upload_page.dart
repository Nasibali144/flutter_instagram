import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/pages/home_page.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/file_service.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);
  static const String id = "upload_page";

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool isLoading = false;
  TextEditingController captionController = TextEditingController();
  File? _image;

  // for image
  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image = await  ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });
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

  // for post
  void _uploadNewPost() {
    String caption = captionController.text.trim().toString();
    if(caption.isEmpty || _image == null) return;

    // Send post  to Server
    _apiPostImage();
  }

  void _apiPostImage() {
    setState(() {
      isLoading = true;
    });

    FileService.uploadImage(_image!, FileService.folderPostImg).then((imageUrl) => {
      _resPostImage(imageUrl),
    });
  }

  void _resPostImage(String imageUrl) {
    String caption = captionController.text.trim().toString();
    Post post = Post(postImage: imageUrl, caption: caption);
    _apiStorePost(post);
  }

  void _apiStorePost(Post post) async {
    // Post to posts folder
    Post posted = await DataService.storePost(post);
    // Post to feeds folder
    DataService.storeFeed(posted).then((value) => {
      _moveToFeed(),
    });
  }

  void _moveToFeed() {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Upload", icon: Icon(Icons.post_add, color: Colors.purple, size: 27.5,), onPressed: _uploadNewPost),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // #image
                  InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: _image != null ?
                      Stack(
                        children: [
                          Image.file(_image!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,),

                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: Icon(Icons.cancel_outlined, color: Colors.white,),
                            ),
                          )
                        ],
                      )
                          : const Center(
                        child: Icon(Icons.add_a_photo, size: 60, color: Colors.grey,),
                      ),
                    ),
                  ),

                  // #caption
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                    child: TextField(
                      controller: captionController,
                      decoration: InputDecoration(
                        hintText: "Caption",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  )
                ],
              ),
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
