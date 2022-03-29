import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/utils.dart';

class FeedWidget extends StatefulWidget {
  final Post post;
  final Function? function;

  const FeedWidget({required this.post, this.function, Key? key}) : super(key: key);

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  bool isLoading = false;

  void _apiPostLike(Post post) async {

    setState(() {
      isLoading = true;
    });
    await DataService.likePost(post, true);
    if(mounted) {
      setState(() {
        isLoading = false;
        post.isLiked = true;
      });
    }
  }

  void _apiUnPostLike(Post post) async {
    setState(() {
      isLoading = true;
    });
    await DataService.likePost(post, false);
    setState(() {
      isLoading = false;
      post.isLiked = false;
    });

    if(widget.function != null) {
      widget.function!();
    }
  }

  void updateLike() {
    if(widget.post.isLiked) {
      _apiUnPostLike(widget.post);
    } else {
      _apiPostLike(widget.post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: widget.post.imageUser != null ? CachedNetworkImage(
                height: 40,
                imageUrl: widget.post.imageUser!,
                placeholder: (context, url) => const Image(image: AssetImage("assets/images/user.png")),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ) : const Image(image: AssetImage("assets/images/user.png"), height: 40,),
            ),
            title: Text(widget.post.fullName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            subtitle: Text(Utils.getMonthDayYear(widget.post.createdDate), style: TextStyle(color: Colors.black)),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz, color: Colors.black, size: 30,),
            ),
          ),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            imageUrl: widget.post.postImage,
            placeholder: (context, url) => Container(color: Colors.grey,),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Row(
            children: [
              IconButton(
                onPressed: updateLike,
                icon: Icon(widget.post.isLiked ? Icons.favorite: Icons.favorite_outline, color: widget.post.isLiked? Colors.red: Colors.black, size: 27.5,),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.paperplane_fill, color: Colors.black, size: 27.5,),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(widget.post.caption, style: TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }
}
