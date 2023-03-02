import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';
import 'package:news_app_client/admin/logic/all_news/all_news_bloc.dart';
import 'package:news_app_client/admin/presentation/news_feed/all_news.dart';
import 'package:news_app_client/routing/routes.dart';
import 'package:news_app_client/widgets/failure_widgets.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllNewsBloc(provider: AdminNewsDataProvider()),
      child: BlocBuilder<AllNewsBloc, AllNewsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: topBar(context),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.createNews);
              },
              child: const Icon(Icons.add),
            ),
            body: Builder(
              builder: (context) {
                if (state is AllNewsInitial) {
                  _fetchNews(context);
                }
                if (state is AllNewsSuccess) {
                  return AllNews(news: state.news);
                }
                if (state is AllNewsFailure) {
                  return FailureWidget(
                    onPressed: () => _resetNews(context),
                    errorMessage: state.error,
                  );
                }
                return const StyledLoadingIndicator();
              },
            ),
          );
        },
      ),
    );
  }

  void _fetchNews(BuildContext context) {
    _allNewsBloc(context).add(FetchAllNews());
  }

  void _resetNews(BuildContext context) {
    _allNewsBloc(context).add(ResetAllNews());
  }

  AllNewsBloc _allNewsBloc(BuildContext context) => context.read<AllNewsBloc>();
}
