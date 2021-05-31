import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Controllers/news_controller.dart';
import 'package:news_api/Models/news_model.dart';
import 'package:news_api/Provider/NewsProvider.dart';
import 'package:news_api/view/Discover/discover.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'Components/GetBody.dart';

class SourceNews extends StatefulWidget {
  final String country,search;

  const SourceNews({Key key, this.country, this.search}) : super(key: key);
  @override
  _SourceNewsState createState() => _SourceNewsState();
}

class _SourceNewsState extends State<SourceNews>
    with SingleTickerProviderStateMixin {

  bool showAppBar = false;
  final scrollController = ScrollController();
  News news;
  List<NewsModel> newsList=[];
  int length;
  NewsProvider newsProvider;
  TabController _tabController;
  bool loading=true;

  Future<List<NewsModel>> getNewsbySources(String sourceKey) async {
    news = News();
    loading = true;
    if(newsList.isNotEmpty){
      newsList.clear();
    }
    newsList = await news.getNewsForCategory(sourceKey);
    newsList = newsList;
    print(loading);
    setState(() {
      loading = false;
    });
    print(loading);
    length = newsList.length;
    _tabController = TabController(length: length , vsync: this);
    print(_tabController.length);
  }

  void getSearchNews(String searchkey) async {
    News newsController = News();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.loading = true;
    newsList=[];
    newsList = await newsController.getNewsbySearch(searchkey);
    setState(() {
      loading = false;
    });


    newsProvider.notifyListeners();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getNewsbySources(widget.country);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: showAppBar
            ? AppBar(
                title: Text(
                  "InShorts",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back, color: Colors.black,),
          ),
              )
            : null,
        body: GestureDetector(
          onTap: () {
            setState(() {
              showAppBar = !showAppBar;
            });
          },
          child: loading?Center(child: CircularProgressIndicator(),) :RotatedBox(
              quarterTurns: 1,
              child: TabBarView(
                controller: _tabController,
                children: List<Widget>.generate(
                  newsList.length,
                      (index) => RotatedBox(
                    quarterTurns: -1,
                    child: getBody(index: index, newslist: newsList),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
