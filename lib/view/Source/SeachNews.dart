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

class SearchNews extends StatefulWidget {
  final String search;

  const SearchNews({Key key, this.search}) : super(key: key);
  @override
  _SearchNewsState createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews>
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
    newsList = await news.getNewsbySearch(sourceKey);
    newsList = newsList;
    setState(() {
      loading = false;
    });
    length = newsList.length;
    _tabController = TabController(length: length , vsync: this);
  }
  Future<List<NewsModel>> getNewsbyKey(String search) async {
    news = News();
    loading = true;

    if(newsList.isNotEmpty){
      newsList.clear();
    }

    newsList =await news.getNewsbySearch(search);
    newsList = newsList;
    setState(() {
      loading = false;
    });
    length = newsList.length;
    _tabController = TabController(length: length , vsync: this);
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

        await getNewsbySources(widget.search);

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
