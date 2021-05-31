

import 'package:news_api/Models/source_model.dart';

List<SourceModel> getSources(){
  List<SourceModel> mySources = [];
  SourceModel sourceModel;


  //Latest Source
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "in";
  sourceModel.sourceName = "Most Recent";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1518281420975-50db6e5d0a97?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80";
  mySources.add(sourceModel);

  //Source 1
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "in";
  sourceModel.sourceName = "India";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1548013146-72479768bada?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80";
  mySources.add(sourceModel);

  //Source 2
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "au";
  sourceModel.sourceName = "Australia";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1527915676329-fd5ec8a12d4b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80";
  mySources.add(sourceModel);

  //Source 3
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "gb";
  sourceModel.sourceName = "UK";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1454537468202-b7ff71d51c2e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=749&q=80";
  mySources.add(sourceModel);

  //Source 4
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "ca";
  sourceModel.sourceName = "Canada";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1490623970972-ae8bb3da443e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=749&q=80";
  mySources.add(sourceModel);

  //Source 5
  sourceModel = new SourceModel();
  sourceModel.sourceKeyword = "us";
  sourceModel.sourceName = "USA";
  sourceModel.imageUrl = "https://images.unsplash.com/photo-1485738422979-f5c462d49f74?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=775&q=80";
  mySources.add(sourceModel);

  return mySources;
}