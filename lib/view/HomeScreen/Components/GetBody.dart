import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/view/NewsPost/news_post.dart';

import '../../../size_config.dart';
class getBody extends StatelessWidget {
  const getBody({
    Key key,
    @required this.newslist, this.index,
  }) : super(key: key);

  final List newslist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: newslist[index].urlToImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: newslist[index].urlToImage,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${newslist[index].title}", style: TextStyle(
                      fontSize: getProportionateScreenWidth(17)
                  ),),
                  SizedBox(height: getProportionateScreenWidth(10),),
                  Text("${newslist[index].content == null? '':newslist[index].content}",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(10),),
                  Text("" + "${newslist[index].author==null? '':newslist[index].author}",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: getProportionateScreenWidth(10)
                    ),),
                ],
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NewsPost(
                      postUrl: newslist[index].articleUrl,
                    )
                ));
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                newslist[index].urlToImage
                            )
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: getProportionateScreenHeight(120),
                    // width: getProportionateScreenWidth(65),
                    decoration: BoxDecoration(
                        color: Colors.black54
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: getProportionateScreenHeight(120),
                    // width: getProportionateScreenWidth(65),
                    decoration: BoxDecoration(
                        color: Colors.black54
                    ),
                    child: Text(
                      "Click Here to Read More",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}