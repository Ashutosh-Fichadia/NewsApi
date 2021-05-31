import 'package:flutter/material.dart';
import 'package:news_api/Controllers/news_controller.dart';
import 'package:news_api/Controllers/source_controller.dart';
import 'package:news_api/Models/source_model.dart';
import 'package:news_api/Provider/NewsProvider.dart';
import 'package:news_api/size_config.dart';
import 'package:news_api/view/Source/SeachNews.dart';
import 'package:provider/provider.dart';

import 'Components/SourceCard.dart';
class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  List<SourceModel> sources = [];
  TextEditingController key= TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sources = getSources();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed:()=> Navigator.pop(context),
        ),
        title: Text(
        "Discover",
        style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    centerTitle: true,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenWidth(10),),
            TextFormField(
              onEditingComplete:(){

                FocusScope.of(context).unfocus();
              },
              controller: key,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SearchNews(
                            search: key.text,
                          )
                      ));
                    },
                    icon: Icon(Icons.search)
                ),
                hintText: "Search Latest News",
                hintStyle: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                ),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(10),),
            SizedBox(height: getProportionateScreenWidth(10),),
            Text("Sources"),
            Text("____"),
            SizedBox(height: getProportionateScreenWidth(10),),
            Expanded(
              child: SizedBox(
                height: 200,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: getProportionateScreenWidth(10),
                    mainAxisSpacing: getProportionateScreenWidth(15),
                    crossAxisCount: 3,
                  children: List<Widget>.generate(
                    sources.length,
                        (index) => SourceCard(
                          categoryName: sources[index].sourceName,
                          imageAssetUrl: sources[index].imageUrl,
                          country: sources[index].sourceKeyword,
                        ),
                  ),
                    ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
