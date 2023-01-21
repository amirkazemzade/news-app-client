import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/routing/routes.dart';
import 'package:news_app_client/user/data/models/category_enum.dart';
import 'package:news_app_client/user/logic/news_feed/news_feed_bloc.dart';
import 'package:news_app_client/user/presentation/news_feed/news_feed.dart';
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
          length: _tabsLength(state),
          child: Builder(builder: (context) {
            var tabBar = const TabBar(
              tabs: [
                Tab(child: StyledLoadingIndicator(width: 18)),
              ],
            );
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settings);
                },
                child: const Icon(Icons.settings),
              ),
              body: Builder(
                builder: (context) {
                  if (state is NewsFeedInitial) {
                    _fetchNews(context);
                  }
                  if (state is NewsFeedSuccess) {
                    return TabBarView(
                      children: _tabBarViewChildren(state),
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

  int _tabsLength(NewsFeedState state) {
    if (state is! NewsFeedSuccess) return 1;
    if (state.news.isEmpty) return 1;
    return state.news.length;
  }

  List<Widget> _tabBarViewChildren(NewsFeedSuccess state) {
    if (state.news.isEmpty) {
      return [
        const Center(child: Text("Sorry, There is no news for you right now!")),
      ];
    }
    return state.news.values
        .map((newsList) => NewsFeed(news: newsList))
        .toList();
  }

  List<Tab> _categories(Iterable<int> categories) {
    if (categories.isEmpty) {
      return [
        const Tab(text: "There is no news!"),
      ];
    }
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
