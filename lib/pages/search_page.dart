import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String id = "search_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  List<User> user = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _apiSearchUsers("");
  }

  void _apiSearchUsers(String keyword) {
    setState(() {
      isLoading = true;
    });
    DataService.searchUsers(keyword).then((users) => _resSearchUser(users));
  }

  void _resSearchUser(List<User> users) {
    setState(() {
      isLoading = false;
      user = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Search"),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // #search
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: TextField(
                  controller: controller,
                  onChanged: (keyword) {
                    _apiSearchUsers(keyword);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200),),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200),),
                      prefixIcon: Icon(Icons.search, color: Colors.grey,),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),

              // #users
              Expanded(
                child: ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index) => itemOfUser(user[index]),
                ),
              )
            ],
          ),

          if(isLoading) const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  Widget itemOfUser(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.purpleAccent, width: 2)
          ),
          padding: EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: user.imageUrl != null ? CachedNetworkImage(
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              imageUrl: user.imageUrl!,
              placeholder: (context, url) => const Image(image: AssetImage("assets/images/user.png")),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ) : const Image(image: AssetImage("assets/images/user.png"), height: 40, width: 40,),
          ),
        ),
        title: Text(user.fullName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        subtitle: Text(user.email, style: TextStyle(color: Colors.black54,)),
        trailing: Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: MaterialButton(
            onPressed: () {},
            child: Text("Follow", style: TextStyle(color: Colors.black87,), ),
          ),
        ),
      ),
    );
  }
}
