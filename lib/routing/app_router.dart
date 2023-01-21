import 'package:flutter/material.dart';
import 'package:news_app_client/admin.representation/admin-login/admin_login_screen.dart';
import 'package:news_app_client/routing/routes.dart';
import 'package:news_app_client/user/presentation/login/auth_screen.dart';
import 'package:news_app_client/user/presentation/news_details/news_details_screen.dart';
import 'package:news_app_client/user/presentation/news_feed/news_feed_screen.dart';
import 'package:news_app_client/user/presentation/settings/settings_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const AuthScreen());
      case Routes.newsFeed:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const NewsFeedScreen());
      case Routes.newsDetails:
        if (arguments is int) {
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => NewsDetailsScreen(newsId: arguments),
          );
        }
        break;
      case Routes.settings:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SettingsScreen(),
        );

      case Routes.adminLogin:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdminLoginScreen(),
        );
    }

    return MaterialPageRoute(builder: (_) => const AuthScreen());
  }
}
