import 'package:flutter/material.dart';
import 'package:news_app_client/presentation/login/auth_screen.dart';
import 'package:news_app_client/presentation/news_details/news_details_screen.dart';
import 'package:news_app_client/presentation/news_feed/news_feed_screen.dart';
import 'package:news_app_client/presentation/settings/settings_screen.dart';
import 'package:news_app_client/routing/routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case Routes.newsFeed:
        return MaterialPageRoute(builder: (_) => const NewsFeedScreen());
      case Routes.newsDetails:
        if (arguments is int) {
          return MaterialPageRoute(
            builder: (_) => NewsDetailsScreen(newsId: arguments),
          );
        }
        break;
      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
    }

    return MaterialPageRoute(builder: (_) => const AuthScreen());
  }
}
