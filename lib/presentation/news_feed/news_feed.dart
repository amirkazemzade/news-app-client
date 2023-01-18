import 'package:flutter/material.dart';
import 'package:news_app_client/data/models/user_news_response_model.dart';
import 'package:news_app_client/presentation/news_feed/news_item.dart';
import 'package:news_app_client/style/dimensions.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key? key, required this.news}) : super(key: key);

  final List<UserNewsItem> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding8,
      itemCount: news.length,
      itemBuilder: (context, index) => NewsItem(item: news[index]),
    );
  }
}
