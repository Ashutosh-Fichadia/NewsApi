import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api/Models/news_model.dart';

class News {


  List<NewsModel> news  = [];
  bool hasMore;

  Future<void> getNews() async{

    String url = "http://newsapi.org/v2/top-headlines?language=en&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    print(response.body);


    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(newsModel);
        }

      });
    }


  }

  Future<List<NewsModel>> getNewsForCategory(String category) async{
    news.clear();

    print(category);
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=$category&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    print("Response = ");
    print(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(newsModel);
        }

      });
      print("News = ");
      print(news.length);
      return news;
    }


  }
  Future<List<NewsModel>> getNewsbySearch(String searchkey) async{
    String url = "https://newsapi.org/v2/everything?q=$searchkey&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";

    print(searchkey);
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    print(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          NewsModel newsModel = NewsModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(newsModel);
        }

      });
      print(news);
      return news;
    }
    else{
      return news;
    }

  }
  // Future<List<NewsModel>> _getExampleServerData(int length) {
  //   return Future.delayed(Duration(seconds: 1), () {
  //     return List<NewsModel>.generate(length, (int index) {
  //       return {
  //         "body": WordPair.random().asPascalCase,
  //         "avatar": 'https://api.adorable.io/avatars/60/${WordPair.random().asPascalCase}.png',
  //       };
  //     });
  //   });
  // }
  // Future<void> loadMore({bool clearCachedData = false}) {
  //   if (clearCachedData) {
  //     _data = [];
  //     hasMore = true;
  //   }
  //   if (_isLoading || !hasMore) {
  //     return Future.value();
  //   }
  //   _isLoading = true;
  //   return _getExampleServerData(10).then((postsData) {
  //     _isLoading = false;
  //     _data.addAll(postsData);
  //     hasMore = (_data.length < 30);
  //     _controller.add(_data);
  //   });
  // }


}