import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/data/repository.dart';
import 'package:news_app_client/logic/theme_brightness_cubit.dart';
import 'package:news_app_client/routing/app_router.dart';
import 'package:news_app_client/style/theme.dart';
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
      child: BlocProvider(
        create: (_) => ThemeBrightnessCubit(),
        child: BlocBuilder<ThemeBrightnessCubit, Brightness>(
          builder: (context, brightness) {
            final themeMode = {
              Brightness.dark: ThemeMode.dark,
              Brightness.light: ThemeMode.light
            };
            return MaterialApp(
              title: 'News App',
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode[brightness],
              onGenerateRoute: AppRouter.onGenerateRoute,
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
