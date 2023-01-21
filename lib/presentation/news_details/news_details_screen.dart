import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/data/models/category_enum.dart';
import 'package:news_app_client/data/repository.dart';
import 'package:news_app_client/logic/news_details/news_details_bloc.dart';
import 'package:news_app_client/logic/news_feed/news_feed_bloc.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/widgets/failure_widgets.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key, required this.newsId}) : super(key: key);

  final int newsId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsDetailsBloc(repository: context.read<Repository>()),
      child: Scaffold(
        appBar: topBar(context),
        body: BlocConsumer<NewsDetailsBloc, NewsDetailsState>(
          listener: (context, state) {
            if (state is NewsDetailsSuccess) {
              context.read<NewsFeedBloc>().add(ResetNewsFeed());
            }
          },
          builder: (context, state) {
            if (state is NewsDetailsInitial) {
              _fetchDetails(context);
            }
            if (state is NewsDetailsFailure) {
              return FailureWidget(
                errorMessage: state.error,
                onPressed: () => _resetDetails(context),
              );
            }
            if (state is NewsDetailsSuccess) {
              var textTheme = Theme.of(context).textTheme;
              return ListView(
                padding: padding64,
                children: [
                  Text(
                    state.news.title!,
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  sizedBoxH32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Text(
                          categoryFromId(state.news.categoryId!).name,
                          style: textTheme.caption,
                        ),
                      ),
                      sizedBoxW8,
                      Chip(
                        label: Text(
                          state.news.viewCount.toString(),
                          style: textTheme.caption,
                        ),
                        avatar: const Icon(Icons.remove_red_eye),
                      ),
                    ],
                  ),
                  sizedBoxH32,
                  Text(
                    state.news.body!,
                    style: textTheme.bodyLarge,
                  )
                ],
              );
            }
            return const StyledLoadingIndicator();
          },
        ),
      ),
    );
  }

  void _fetchDetails(BuildContext context) {
    context.read<NewsDetailsBloc>().add(FetchNewsDetails(newsId: newsId));
  }

  void _resetDetails(BuildContext context) {
    context.read<NewsDetailsBloc>().add(ResetNewsDetails());
  }
}
