import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/data.dart';
import 'package:flutter_news_app/helper/news.dart';
import 'package:flutter_news_app/helper/widgets.dart';
import 'package:flutter_news_app/models/category.dart';
import 'package:flutter_news_app/views/category_news.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isLoading = true;
  var newsList;

  List<Category> categories = [];

  void getNews() async{
    News news = News();
    await news.getNews();
    newsList = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;

    super.initState();

    categories = getCategory();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Text("Labs", style: TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),),
          Text("News", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w600),),
            Text("Hub", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.w600),),
        ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : newsList == null || newsList.isEmpty
            ? Center(child: Text("No news found."))
      :  SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                /// Categories
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          imageAssetUrl: categories[index].imageAssetUrl,
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),

                /// News Article
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListView.builder(
                      itemCount: newsList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newsList[index].urlToImage ?? "",
                          title: newsList[index].title ?? "",
                          desc: newsList[index].description ?? "",
                          content: newsList[index].content ?? "",
                          postUrl: newsList[index].articleUrl ?? "",
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  const CategoryCard({super.key, required this.imageAssetUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(newsCategory: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(imageUrl: imageAssetUrl, height: 60, width: 120, fit: BoxFit.cover, errorWidget: (context, url, error) => Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
