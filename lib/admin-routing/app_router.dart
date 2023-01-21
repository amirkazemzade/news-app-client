import 'package:flutter/material.dart';
import 'package:news_app_client/admin-routing/routes.dart';
import 'package:news_app_client/admin.representation/admin-login/admin_login_screen.dart';

class AdminAppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case AdminRoutes.adminLogin:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdminLoginScreen(),
        );
    }

    return MaterialPageRoute(builder: (_) => const AdminLoginScreen());
  }
}
