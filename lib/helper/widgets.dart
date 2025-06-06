import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/views/article_view.dart';

Widget MyAppBar() {
  return AppBar(
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text("Flutter", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),
      Text("News", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)
    ],),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl;

  const NewsTile({super.key, required this.imgUrl, required this.title, required this.desc, required this.content, required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(postUrl: postUrl)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              )),
          SizedBox(height: 12,),
          Text(title, maxLines: 2, style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),),
          SizedBox(height: 4,),
          Text(desc, maxLines: 2, style: TextStyle(color: Colors.black54, fontSize: 14),)
        ],
      ),
    );
  }
}
