import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/logic/theme_brightness_cubit.dart';

PreferredSizeWidget? topBar(BuildContext context,
    {PreferredSizeWidget? bottom, List<Widget>? actions}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      "News App",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    actions: actions ??
        [
          BlocBuilder<ThemeBrightnessCubit, Brightness>(
            builder: (context, brightness) {
              final icons = {
                Brightness.dark: Icons.light_mode,
                Brightness.light: Icons.dark_mode,
              };
              return IconButton(
                onPressed: () => _revertBrightness(context, brightness),
                icon: Icon(icons[brightness]),
              );
            },
      ),
      const SizedBox(width: 8),
    ],
    bottom: bottom,
  );
}

void _revertBrightness(BuildContext context, Brightness brightness) {
  final oppositeBrightness = {
    Brightness.dark: Brightness.light,
    Brightness.light: Brightness.dark,
  };

  context
      .read<ThemeBrightnessCubit>()
      .setBrightness(oppositeBrightness[brightness]!);
}
