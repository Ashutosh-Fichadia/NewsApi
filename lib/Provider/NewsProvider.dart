import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Models/news_model.dart';
class NewsProvider extends ChangeNotifier {
  List<NewsModel> newsList;
  bool loading= true;
  String key;
  TabController tabController;
}