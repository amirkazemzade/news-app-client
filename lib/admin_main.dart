import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin-routing/app_router.dart';
import 'package:news_app_client/admin-routing/routes.dart';
import 'package:news_app_client/style/theme.dart';
import 'package:news_app_client/user/data/repository.dart';
import 'package:news_app_client/user/logic/news_feed/news_feed_bloc.dart';
import 'package:news_app_client/user/logic/theme_brightness_cubit.dart';
import 'package:sizing/sizing_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeBrightnessCubit(),
          ),
          BlocProvider(
            create: (context) =>
                NewsFeedBloc(repository: Repository()),
          ),
        ],
        child: BlocBuilder<ThemeBrightnessCubit, Brightness>(
          builder: (context, brightness) {
            final themeMode = {
              Brightness.dark: ThemeMode.dark,
              Brightness.light: ThemeMode.light
            };
            return MaterialApp(
              title: 'News App Admin',
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode[brightness],
              initialRoute: AdminRoutes.adminLogin,
              onGenerateRoute: AdminAppRouter.onGenerateRoute,
              builder: (_, child) {
                return SizingBuilder(
                  builder: () => child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
