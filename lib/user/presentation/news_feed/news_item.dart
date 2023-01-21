import 'package:flutter/material.dart';
import 'package:news_app_client/routing/routes.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/user/data/models/user_news_response_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key, required this.item}) : super(key: key);

  final UserNewsItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.newsDetails, arguments: item.id);
      },
      child: Card(
        child: Padding(
          padding: padding8,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Chip(
                label: Text(item.viewCount.toString()),
                avatar: const Icon(Icons.remove_red_eye),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
