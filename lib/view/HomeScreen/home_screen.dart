import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Controllers/news_controller.dart';
import 'package:news_api/Provider/NewsProvider.dart';
import 'package:news_api/view/Discover/discover.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'Components/GetBody.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool showAppBar = false;
  final scrollController = ScrollController();
  // DataProvider dp = Provider.of<DataProvider>(context,listen: false);
  News news;
  int length,val=0;
  NewsProvider newsProvider;

  void getNews() async {
    news = News();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    await news.getNews();
    newsProvider.newsList = news.news;
    newsProvider.notifyListeners();
    setState(() {
      newsProvider.loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getNews();
      length = newsProvider.newsList.length;
      print(val);
      newsProvider.tabController = TabController(length: length , vsync: this);
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
          actions: <Widget>[
            Row(
              children: [
                Center(
                  child: Text(
                    "Discover",
                    style: TextStyle(color: Colors.black),),),
                IconButton(
                  icon: const Icon(Icons.arrow_forward,color: Colors.black,),
                  tooltip: 'Open shopping cart',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Discover()
                    ));
                    // handle the press
                  },
                ),
              ],
            ),
          ],
              )
            : null,
        body: GestureDetector(
          onTap: () {
            setState(() {
              showAppBar = !showAppBar;
            });
          },
          child: Consumer<NewsProvider>(
            builder: (_, newsProvider,child) => newsProvider.loading?Center(
              child: CircularProgressIndicator(),
            ):RotatedBox(
              quarterTurns: 1,
              child: TabBarView(
                controller: newsProvider.tabController,
                children: List<Widget>.generate(
                  newsProvider.newsList.length,
                      (index) => RotatedBox(
                    quarterTurns: -1,
                    child: getBody(index: index, newslist: newsProvider.newsList),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
