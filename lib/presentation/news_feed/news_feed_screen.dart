import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/data/models/category_enum.dart';
import 'package:news_app_client/logic/news_feed/news_feed_bloc.dart';
import 'package:news_app_client/presentation/news_feed/news_feed.dart';
import 'package:news_app_client/widgets/failure_widgets.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsFeedBloc, NewsFeedState>(
      builder: (context, state) {
        return DefaultTabController(
          length: state is NewsFeedSuccess ? state.news.length : 1,
          child: Builder(builder: (context) {
            var tabBar = const TabBar(tabs: [
              Tab(child: StyledLoadingIndicator(width: 18)),
            ]);
            if (state is NewsFeedSuccess) {
              final categoryIds = state.news.keys;
              tabBar = TabBar(
                labelColor: Theme.of(context).colorScheme.onSurface,
                indicatorColor: Theme.of(context).colorScheme.onSurface,
                tabs: _categories(categoryIds),
              );
            }
            return Scaffold(
              appBar: topBar(context, bottom: tabBar),
              body: Builder(
                builder: (context) {
                  if (state is NewsFeedInitial) {
                    _fetchNews(context);
                  }
                  if (state is NewsFeedSuccess) {
                    return TabBarView(
                      children: state.news.values
                          .map((newsList) => NewsFeed(news: newsList))
                          .toList(),
                    );
                  }
                  if (state is NewsFeedFailure) {
                    return FailureWidget(
                      onPressed: () => _resetNews(context),
                      errorMessage: state.error,
                    );
                  }
                  return const StyledLoadingIndicator();
                },
              ),
            );
          }),
        );
      },
    );
  }

  List<Tab> _categories(Iterable<int> categories) {
    return categories.map(
      (categoryId) {
        return Tab(text: categoryFromId(categoryId).name);
      },
    ).toList();
  }

  void _fetchNews(BuildContext context) {
    _newsFeedBloc(context).add(FetchNewsFeed());
  }

  void _resetNews(BuildContext context) {
    _newsFeedBloc(context).add(ResetNewsFeed());
  }

  NewsFeedBloc _newsFeedBloc(BuildContext context) =>
      context.read<NewsFeedBloc>();
}
