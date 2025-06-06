import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/news.dart';
import 'package:flutter_news_app/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  const CategoryNews({super.key, required this.newsCategory});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newsList;
  bool _isLoading = true;

  @override
  void initState() {
    getNews();

    super.initState();
  }

  void getNews() async{
    NewsForCategory news = NewsForCategory();
    await news.getNewsForCategory(widget.newsCategory);
    newsList = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text("Labs", style: TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),),
          Text("News", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w600),),
          Text("Hub", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.w600),),
        ],
        ),
        actions: <Widget>[
          Opacity(opacity: 0, child: Container(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.share),),)
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),)
          : newsList == null || newsList.isEmpty
          ? Center(child: Text("No articles found."))
          : SingleChildScrollView(
        child: Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListView.builder(
                itemCount: newsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
              return NewsTile(imgUrl: newsList[index].urlToImage ?? "", title: newsList[index].title ?? "", desc: newsList[index].description ?? "", content: newsList[index].content ?? "", postUrl: newsList[index].articleUrl ?? "");
            }),
          ),
        ),
      ) ,
    );
  }
}
