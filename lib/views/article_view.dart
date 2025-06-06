import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;

  const ArticleView({super.key, required this.postUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.postUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Text("Labs", style: TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),),
        Text("News", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w600),),
        Text("Hub", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.w600),),
      ],),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebViewWidget(controller: _controller)),
    );
  }
}
