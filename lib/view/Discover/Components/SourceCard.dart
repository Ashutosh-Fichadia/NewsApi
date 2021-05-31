import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Controllers/news_controller.dart';
import 'package:news_api/Models/news_model.dart';
import 'package:news_api/Provider/NewsProvider.dart';
import 'package:news_api/view/Source/SourceNews.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
class SourceCard extends StatefulWidget {
  final String imageAssetUrl, categoryName,country;

  const SourceCard({Key key, this.imageAssetUrl, this.categoryName, this.country}) : super(key: key);

  @override
  _SourceCardState createState() => _SourceCardState();
}

class _SourceCardState extends State<SourceCard> {

  var newList =[];
  News news;
  NewsProvider newsProvider;

  Future<List<NewsModel>> getNewsbySources(String sourceKey) async {
    news = News();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.loading = true;
    print(newsProvider.loading);
    newsProvider.newsList=[];

    if(newsProvider.newsList.isNotEmpty){
      newsProvider.newsList.clear();
    }

    newList = await news.getNewsForCategory(sourceKey);
    newsProvider.newsList = newList;
    newsProvider.loading = false;

    newsProvider.notifyListeners();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => SourceNews(
              country: widget.country
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(12)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
              child: CachedNetworkImage(
                imageUrl: widget.imageAssetUrl,
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenWidth(150),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: getProportionateScreenHeight(150),
              width: getProportionateScreenWidth(150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
                  color: Colors.black26
              ),
              child: Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
