import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/user/data/models/news_list_response_model.dart';
import 'package:news_app_client/user/presentation/news_feed/news_item.dart';

class AllNews extends StatelessWidget {
  const AllNews({Key? key, required this.news}) : super(key: key);

  final List<NewsItemModel> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding8,
      itemCount: news.length,
      itemBuilder: (context, index) => NewsItem(item: news[index]),
    );
  }
}
